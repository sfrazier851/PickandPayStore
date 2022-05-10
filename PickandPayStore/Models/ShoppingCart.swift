//
//  ShoppingCart.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

// ShoppingCart Model is for all Database operations for the entity.
// NOTE: the order of public properties matters and MUST match the order of columns
//   in the database table definition.
struct ShoppingCart: Equatable {
    var id: Int = 0
    var userID: Int = 0
    var productID: Int = 0
    var date_added: String = ""
    
    // pass in the database for the application
    private static var shoppingCartDAL: ShoppingCartDAL? = ShoppingCartDAL(db: SQLiteDatabase.getDatabase(), convert: convert)
    
    // set the database to be an in-memory database for tests
    static func setTestingTrue() {
        shoppingCartDAL = ShoppingCartDAL(db: SQLiteDatabase.getInMemoryTestDatabase(), convert: convert)
    }
    
    // Convert query result set to Array of ShoppingCart
    static func convert(shoppingCartResultSet: [[String]]) -> [ShoppingCart]? {
        var cartProducts = [ShoppingCart]()
        for cartProduct_row in shoppingCartResultSet {
            let columns = cartProduct_row
            
            var cartProduct = ShoppingCart()
            cartProduct.id = Int(columns[0])!
            cartProduct.userID = Int(columns[1])!
            cartProduct.productID = Int(columns[2])!
            cartProduct.date_added = columns[3]
            
            cartProducts.append(cartProduct)
        }
        return cartProducts
    }
    
    static func getAll() -> [ShoppingCart]? {
        guard let shoppingCartDAL = shoppingCartDAL else {
            return nil
        }
        return shoppingCartDAL.getAllShoppingCartProducts()
    }
    
    static func getByID(shoppingCartID: Int) -> [ShoppingCart]? {
        guard let shoppingCartDAL = shoppingCartDAL else {
            return nil
        }
        return shoppingCartDAL.getShoppingCartByID(shoppingCartID: shoppingCartID)
    }
    
    static func getByUserID(userID: Int) -> [ShoppingCart]? {
        guard let shoppingCartDAL = shoppingCartDAL else {
            return nil
        }
        return shoppingCartDAL.getShoppingCartByUserID(userID: userID)
    }
    
    static func create(userID: Int, productID: Int) -> ShoppingCart? {
        guard let shoppingCartDAL = shoppingCartDAL else {
            return nil
        }
        return shoppingCartDAL.createShoppingCartProduct(userID: userID, productID: productID)
    }
}
