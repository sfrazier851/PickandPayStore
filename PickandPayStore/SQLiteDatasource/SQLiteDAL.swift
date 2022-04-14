//
//  SQLiteDAL.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation
import SQLite3

class SQLiteDAL {
    
    private let db: OpaquePointer?
    
    init(db: OpaquePointer?) {
        self.db = db
    }
    
    // return array of types, for class properties
    // in order of declaration
    private static func getColumnTypes(modelType: Any) -> [String] {
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
    static func protectedGetLatestInsertId() -> Int? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        let lastRowId = sqlite3_last_insert_rowid(db)
        return Int(lastRowId)
    }
    
    // general purpose query (NOTE: QUERY MUST RETURN ALL FIELDS OF TABLE!)
    static func protectedQuery(modelType: Any, queryString: String) -> [[String]]? {
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
