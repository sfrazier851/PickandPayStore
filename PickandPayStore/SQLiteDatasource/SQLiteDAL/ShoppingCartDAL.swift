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
    private let db: OpaquePointer?
    // function defined in corresponding model struct
    private let convert: (_ shoppingCartResultSet: [[String]]) -> [ShoppingCart]?
    
    init(db: OpaquePointer?, convert: @escaping (_ shoppingCartResultSet: [[String]]) -> [ShoppingCart]?) {
        self.convert = convert
        self.db = db
        super.init(db: db)
    }

    // ShoppingCart DAL (getAllShoppingCartProducts, getShoppingCartByUserID, createShoppingCartProduct)
    func getAllShoppingCartProducts() -> [ShoppingCart]? {
        guard let shoppingCartResultSet = ShoppingCartDAL.protectedQuery(modelType: shoppingcart, queryString: "SELECT * FROM ShoppingCart;") else {
            return nil
        }
        return self.convert(shoppingCartResultSet)
    }
    
    func getShoppingCartByID(shoppingCartID: Int) -> [ShoppingCart]? {
        guard let shoppingCartResultSet = ShoppingCartDAL.protectedQuery(modelType: shoppingcart, queryString: "SELECT * FROM ShoppingCart WHERE ID = '\(shoppingCartID)';") else {
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
    
    func createShoppingCartProduct(userID: Int, productID: Int) -> ShoppingCart? {
        guard let db = self.db else {
            return nil
        }
        let insertStatementString = "INSERT INTO ShoppingCart ( userID, productID ) VALUES ( ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(userID))
            sqlite3_bind_int(insertStatement, 2, Int32(productID))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
        
        let newShoppingCartID = ShoppingCartDAL.protectedGetLatestInsertId()!
        return ShoppingCart.getByID(shoppingCartID: newShoppingCartID)![0]
    }
}
