//
//  ShoppingCartDAL.swift
//  PickandPayStore
//
//  Created by iMac on 4/14/22.
//

import Foundation
import SQLite3

class ShoppingCartDAL: SQLiteDAL {
        
    private let shoppingcart = ShoppingCart()
    private let convert: (_ shoppingCartResultSet: [[String]]) -> [ShoppingCart]?
    
    init(db: OpaquePointer?, convert: @escaping (_ shoppingCartResultSet: [[String]]) -> [ShoppingCart]?) {
        self.convert = convert
        super.init(db: db)
    }

    // ShoppingCart DAL (getAllShoppingCartProducts, getShoppingCartByUserID, createShoppingCartProduct)
    func getAllShoppingCartProducts() -> [ShoppingCart]? {
        guard let shoppingCartResultSet = ShoppingCartDAL.protectedQuery(modelType: shoppingcart, queryString: "SELECT * FROM ShoppingCart;") else {
            return nil
        }
        return self.convert(shoppingCartResultSet)
    }
    
    func getShoppingCartByUserID(userID: Int) -> [ShoppingCart]? {
        guard let shoppingCartResultSet = ShoppingCartDAL.protectedQuery(modelType: shoppingcart, queryString: "SELECT * FROM ShoppingCart WHERE userID = '\(userID)';") else {
            return nil
        }
        return self.convert(shoppingCartResultSet)
    }
    
    func createShoppingCartProduct(userID: Int, productID: Int) -> Bool? {
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
}
