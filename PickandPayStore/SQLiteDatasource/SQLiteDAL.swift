//
//  SQLiteDAL.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation
import SQLite3

class SQLiteDAL {
    
    // return array of types, for class properties
    // in order of declaration
    static func getColumnTypes(modelType: Any) -> [String] {
        let mirror = Mirror(reflecting: modelType)
        var columnTypes = [String]()
        
        for prop in mirror.children {
            columnTypes.append(String(describing: type(of: prop.value)))
        }
        return columnTypes
    }
    
    // Return latest row id.
    // For getting id of most recently
    // created db entity.
    static func getLatestInsertId() -> Int? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        let lastRowId = sqlite3_last_insert_rowid(db)
        return Int(lastRowId)
    }
    
    // general purpose query (NOTE: QUERY MUST RETURN ALL FIELDS OF TABLE!)
    static func query(modelType: Any, queryString: String) -> [[String]]? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        
        let columnTypes = getColumnTypes(modelType: modelType)
        
        // initialize the result set array of arrays ( rows : [ columns [] ]  )
        var rowsArr = [[String]]()
        var columnsArr = [String]()
        
        var stmt: OpaquePointer?
        
        //prepare query
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("error running query: \(error)")
            exit(1)
        }
        
        // iterate through result set rows
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            var i = 0
            // iterate through columns
            while i < columnTypes.count {
                var column: String
                
                switch columnTypes[i] {
                    case "Float":
                        column = String(sqlite3_column_double(stmt, Int32(i)))
                    case "Int":
                        column = String(sqlite3_column_int(stmt, Int32(i)))
                    case "Bool":
                        column = String(sqlite3_column_int(stmt, Int32(i)))
                    default: //String
                        column = String(cString: sqlite3_column_text(stmt, Int32(i)))
                }
                columnsArr.append(column)
                i += 1
            }
            rowsArr.append(columnsArr)
            // clear columns array for next row
            columnsArr.removeAll()
        }
        // delete compiled statment to avoid resource leaks
        sqlite3_finalize(stmt)
        return rowsArr
    }
    
    // User DAL (getAllUsers, getUsersByEmail, createUser)
    static func getAllUsers() -> [User]? {
        guard let usersResultSet = query(modelType: User.user, queryString: "SELECT * FROM User;") else {
            return nil
        }
        return User.convert(usersResultSet: usersResultSet)
    }
    
    static func getUserByID(userID: Int) -> [User]? {
        guard let usersResultSet = query(modelType: User.user, queryString: "SELECT * FROM User WHERE ID = '\(userID)';") else {
            return nil
        }
        return User.convert(usersResultSet: usersResultSet)
    }
    
    static func getUsersByEmail(email: String) -> [User]? {
        guard let usersResultSet = query(modelType: User.user, queryString: "SELECT * FROM User WHERE email = '\(email)';") else {
            return nil
        }
        return User.convert(usersResultSet: usersResultSet)
    }
    
    static func getUsersByUsername(username: String) -> [User]? {
        guard let usersResultSet = query(modelType: User.user, queryString: "SELECT * FROM User WHERE username = '\(username)';") else {
            return nil
        }
        return User.convert(usersResultSet: usersResultSet)
    }
    
    static func createUser(username: String, email: String, password: String, phoneNumber: String) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO User ( username, email, password, phone_number, balance ) VALUES ( ?, ?, ?, ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, NSString(string: username).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, NSString(string: email).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, NSString(string: password).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, NSString(string: phoneNumber).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 5, Double(0.0))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\nINSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }
    
    // Department DAL (getAllDepartments, getByDepartmentsByName, createDepartment)
//    static func getAllDepartments() -> [Department]? {
//        guard let departmentsResultSet = query(modelType: Department.department, queryString: "SELECT * FROM Department;") else {
//            return nil
//        }
//        return Department.convert(departmentsResultSet: departmentsResultSet)
//    }
//    
//    static func getDepartmentsByName(name: String) -> [Department]? {
//        guard let departmentsResultSet = query(modelType: Department.department, queryString: "SELECT * FROM Department WHERE name = '\(name)';") else {
//            return nil
//        }
//        return Department.convert(departmentsResultSet: departmentsResultSet)
//    }
    
    static func createDepartment(name: String, imageName: String) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO Department ( name, imageName ) VALUES ( ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, NSString(string: name).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, NSString(string: imageName).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }
    
    // Category DAL (getAllCategories, getCategoriesByName, createCategory)
    static func getAllCategories() -> [CategoryM]? {
        guard let categoriesResultSet = query(modelType: CategoryM.category, queryString: "SELECT * FROM Category;") else {
            return nil
        }
        return CategoryM.convert(categoriesResultSet: categoriesResultSet)
    }
    
    static func getCategoriesByName(name: String) -> [CategoryM]? {
        guard let categoriesResultSet = query(modelType: CategoryM.category, queryString: "SELECT * FROM Category WHERE name = '\(name)';") else {
            return nil
        }
        return CategoryM.convert(categoriesResultSet: categoriesResultSet)
    }
    
    static func createCategory(name: String, imageName: String) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO Category ( name, imageName ) VALUES ( ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            //sqlite3_bind_int(insertStatement, 1, Int32(departmentID))
            sqlite3_bind_text(insertStatement, 1, NSString(string: name).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, NSString(string: imageName).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }
    
    // Product DAL (getAllProducts, getProductsByName, createProduct)
    static func getAllProducts() -> [ProductM]? {
        guard let productsResultSet = query(modelType: ProductM.product, queryString: "SELECT * FROM Product;") else {
            return nil
        }
        return ProductM.convert(productsResultSet: productsResultSet)
    }
    
    static func getProductByID(productID: Int) -> [ProductM]? {
        guard let productsResultSet = query(modelType: ProductM.product, queryString: "SELECT * FROM Product WHERE ID = '\(productID)';") else {
            return nil
        }
        return ProductM.convert(productsResultSet: productsResultSet)
    }
    
    static func getProductsByName(name: String) -> [ProductM]? {
        guard let productsResultSet = query(modelType: ProductM.product, queryString: "SELECT * FROM Product WHERE name = '\(name)';") else {
            return nil
        }
        return ProductM.convert(productsResultSet: productsResultSet)
    }
    
    static func createProduct(categoryID: Int, name: String, price: Float, imageName: String, description: String) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO Product ( categoryID, name, price, imageName, description ) VALUES ( ?, ?, ?, ?, ?)"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
           // sqlite3_bind_int(insertStatement, 1, Int32(departmentID))
            sqlite3_bind_int(insertStatement, 1, Int32(categoryID))
            sqlite3_bind_text(insertStatement, 2, NSString(string: name).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 3, Double(price))
            sqlite3_bind_text(insertStatement, 4, NSString(string: imageName).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, NSString(string: description).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }
    
    // ProductReview DAL (getAllProductReviews, getReviewsByProductID, createProductReview)
    static func getAllProductReviews() -> [ProductReview]? {
        guard let productReviewsResultSet = query(modelType: ProductReview.productreview, queryString: "SELECT * FROM ProductReview;") else {
            return nil
        }
        return ProductReview.convert(productReviewsResultSet: productReviewsResultSet)
    }
    
    static func getReviewsByProductID(productID: Int) -> [ProductReview]? {
        guard let productReviewsResultSet = query(modelType: ProductReview.productreview, queryString: "SELECT * FROM ProductReview WHERE productID = '\(productID)';") else {
            return nil
        }
        return ProductReview.convert(productReviewsResultSet: productReviewsResultSet)
    }
    
    static func createProductReview(userID: Int, productID: Int, review: String) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO ProductReview ( userID, productID, review ) VALUES ( ?, ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(userID))
            sqlite3_bind_int(insertStatement, 2, Int32(productID))
            sqlite3_bind_text(insertStatement,3, NSString(string: review).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }
    
    // Wishlist DAL (getAllWishlistProducts, getWishlistByUserID, createWishlistProduct)
    static func getAllWishlistProducts() -> [Wishlist]? {
        guard let wishlistProductsResultSet = query(modelType: Wishlist.wishlist, queryString: "SELECT * FROM Wishlist;") else {
            return nil
        }
        return Wishlist.convert(wishlistResultSet: wishlistProductsResultSet)
    }
    
    static func getWishlistByUserID(userID: Int) -> [Wishlist]? {
        guard let wishlistProductsResultSet = query(modelType: Wishlist.wishlist, queryString: "SELECT * FROM Wishlist WHERE userID = '\(userID)';") else {
            return nil
        }
        return Wishlist.convert(wishlistResultSet: wishlistProductsResultSet)
    }
    
    static func createWishlistProduct(userID: Int, productID: Int) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO Wishlist ( userID, productID ) VALUES ( ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(userID))
            sqlite3_bind_int(insertStatement, 2, Int32(productID))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }
    
    // ShoppingCart DAL (getAllShoppingCartProducts, getShoppingCartByUserID, createShoppingCartProduct)
    static func getAllShoppingCartProducts() -> [ShoppingCart]? {
        guard let shoppingCartResultSet = query(modelType: ShoppingCart.shoppingcart, queryString: "SELECT * FROM ShoppingCart;") else {
            return nil
        }
        return ShoppingCart.convert(shoppingCartResultSet: shoppingCartResultSet)
    }
    
    static func getShoppingCartByUserID(userID: Int) -> [ShoppingCart]? {
        guard let shoppingCartResultSet = query(modelType: ShoppingCart.shoppingcart, queryString: "SELECT * FROM ShoppingCart WHERE userID = '\(userID)';") else {
            return nil
        }
        return ShoppingCart.convert(shoppingCartResultSet: shoppingCartResultSet)
    }
    
    static func createShoppingCartProduct(userID: Int, productID: Int) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO ShoppingCart ( userID, productID ) VALUES ( ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(userID))
            sqlite3_bind_int(insertStatement, 2, Int32(productID))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }
    
    // PurchaseOrder DAL (getAllPurchaseOrders, getPurchaseOrdersByUserID, createPurchaseOrder)
    static func getAllPurchaseOrders() -> [PurchaseOrder]? {
        guard let purchaseOrderResultSet = query(modelType: PurchaseOrder.purchaseorder, queryString: "SELECT * FROM PurchaseOrder;") else {
            return nil
        }
        return PurchaseOrder.convert(purchaseOrderResultSet: purchaseOrderResultSet)
    }
    
    static func getPurchaseOrderByID(purchaseOrderID: Int) -> [PurchaseOrder]? {
        guard let purchaseOrderResultSet = query(modelType: PurchaseOrder.purchaseorder, queryString: "SELECT * FROM PurchaseOrder WHERE ID = '\(purchaseOrderID)';") else {
            return nil
        }
        return PurchaseOrder.convert(purchaseOrderResultSet: purchaseOrderResultSet)
    }
    
    static func getPurchaseOrdersByUserID(userID: Int) -> [PurchaseOrder]? {
        guard let purchaseOrderResultSet = query(modelType: PurchaseOrder.purchaseorder, queryString: "SELECT * FROM PurchaseOrder WHERE userID = '\(userID)';") else {
            return nil
        }
        return PurchaseOrder.convert(purchaseOrderResultSet: purchaseOrderResultSet)
    }
    
    static func createPurchaseOrder(userID: Int, paymentType: String) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO PurchaseOrder ( userID, paymentType ) VALUES ( ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(userID))
            sqlite3_bind_text(insertStatement, 2, NSString(string: paymentType).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }
    
    // OrderItem DAL (getAllOrderItems, getByPurchaseOrderID, createOrderItem)
    static func getAllOrderItems() -> [OrderItem]? {
        guard let orderItemsResultSet = query(modelType: OrderItem.orderitem, queryString: "SELECT * FROM OrderItem;") else {
            return nil
        }
        return OrderItem.convert(orderItemsResultSet: orderItemsResultSet)
    }
    
    static func getOrderItemByPurchaseOrderID(purchaseOrderID: Int) -> [OrderItem]? {
        guard let orderItemsResultSet = query(modelType: OrderItem.orderitem, queryString: "SELECT * FROM OrderItem WHERE purchaseOrderID = '\(purchaseOrderID)';") else {
            return nil
        }
        return OrderItem.convert(orderItemsResultSet: orderItemsResultSet)
    }
    
    static func createOrderItem(purchaseOrderID: Int, productID: Int, purchasePrice: Float) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO OrderItem ( purchaseOrderID, productID, purchasePrice ) VALUES ( ?, ?, ?)"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(purchaseOrderID))
            sqlite3_bind_int(insertStatement, 2, Int32(productID))
            sqlite3_bind_double(insertStatement, 3, Double(purchasePrice))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }

}
