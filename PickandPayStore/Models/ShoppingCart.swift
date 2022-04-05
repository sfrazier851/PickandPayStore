//
//  ShoppingCart.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct ShoppingCart {
    var id: Int = 0
    var userID: Int = 0
    var productID: Int = 0
    var date_added: String = ""
    
    static let shoppingcart = ShoppingCart()
    
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
        return SQLiteDAL.getAllShoppingCartProducts()
    }
    
    static func getByUserID(userID: Int) -> [ShoppingCart]? {
        return SQLiteDAL.getShoppingCartByUserID(userID: userID)
    }
    
    static func create(userID: Int, productID: Int) -> Bool? {
        return SQLiteDAL.createShoppingCartProduct(userID: userID, productID: productID)
    }
}
