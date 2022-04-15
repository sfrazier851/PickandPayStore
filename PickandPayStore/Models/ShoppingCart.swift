//
//  ShoppingCart.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct ShoppingCart: Equatable {
    var id: Int = 0
    var userID: Int = 0
    var productID: Int = 0
    var date_added: String = ""
    
    private static var testing: Bool = false
    static func setTestingTrue() { ShoppingCart.testing = true }

    private static let shoppingCartDAL = { () -> ShoppingCartDAL? in
        if ShoppingCart.testing == true {
            if let db = SQLiteDatabase.getUnitTestDatabase() {
                return ShoppingCartDAL(db: db, convert: convert)
            }
        } else {
            if let db = SQLiteDatabase.getDatabase() {
                return ShoppingCartDAL(db: db, convert: convert)
            }
        }
        return nil
    }()
    
    // Convert query result set to Array of Wishlist
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
