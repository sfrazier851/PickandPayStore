//
//  ProductDAL.swift
//  PickandPayStore
//
//  Created by iMac on 4/14/22.
//

import Foundation
import SQLite3

class ProductDAL: SQLiteDAL {
        
    private let product = Product()
    private let convert: (_ productsResultSet: [[String]]) -> [Product]?
    
    init(db: OpaquePointer?, convert: @escaping (_ productsResultSet: [[String]]) -> [Product]?) {
        self.convert = convert
        super.init(db: db)
    }

    // Product DAL (getAllProducts, getProductsByName, createProduct)
    func getAllProducts() -> [Product]? {
        guard let productsResultSet = ProductDAL.protectedQuery(modelType: product, queryString: "SELECT * FROM Product;") else {
            return nil
        }
        return self.convert(productsResultSet)
    }

    func getProductByID(productID: Int) -> [Product]? {
        guard let productsResultSet = ProductDAL.protectedQuery(modelType: product, queryString: "SELECT * FROM Product WHERE ID = '\(productID)';") else {
            return nil
        }
        return self.convert(productsResultSet)
    }

    func getProductsByName(name: String) -> [Product]? {
        guard let productsResultSet = ProductDAL.protectedQuery(modelType: product, queryString: "SELECT * FROM Product WHERE name = '\(name)';") else {
            return nil
        }
        return self.convert(productsResultSet)
    }

    func createProduct(categoryID: Int, name: String, price: Float, imageName: String, description: String) -> Bool? {
        guard let db = SQLiteDatabase.getDatabase() else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO Product ( categoryID, name, price, imageName, description ) VALUES ( ?, ?, ?, ?, ?)"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
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
}
