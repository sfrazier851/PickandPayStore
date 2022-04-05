//
//  Wishlist.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct Wishlist {
    var id: Int = 0
    var userID: Int = 0
    var productID: Int = 0
    var date_added: String = ""
    
    static let wishlist = Wishlist()
    
    // Convert query result set to Array of Wishlist
    static func convert(wishlistResultSet: [[String]]) -> [Wishlist]? {
        var wishlistProducts = [Wishlist]()
        for wishlist_row in wishlistResultSet {
            let columns = wishlist_row
            
            var wishlistProduct = Wishlist()
            wishlistProduct.id = Int(columns[0])!
            wishlistProduct.userID = Int(columns[1])!
            wishlistProduct.productID = Int(columns[2])!
            wishlistProduct.date_added = columns[3]
            
            wishlistProducts.append(wishlistProduct)
        }
        return wishlistProducts
    }
    
    static func getAll() -> [Wishlist]? {
        return SQLiteDAL.getAllWishlistProducts()
    }
    
    static func getByUserID(userID: Int) -> [Wishlist]? {
        return SQLiteDAL.getWishlistByUserID(userID: userID)
    }
    
    static func create(userID: Int, productID: Int) -> Bool? {
        return SQLiteDAL.createWishlistProduct(userID: userID, productID: productID)
    }
}
