//
//  Wishlist.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

// Wishlist Model is for all Database operations for the entity.
// NOTE: the order of public properties matters and MUST match the order of columns
//   in the database table definition.
struct Wishlist: Equatable {
    var id: Int = 0
    var userID: Int = 0
    var productID: Int = 0
    var date_added: String = ""
    
    // pass in the database for the application
    private static var wishlistDAL: WishlistDAL? = WishlistDAL(db: SQLiteDatabase.getDatabase(), convert: convert)
    
    // set the database to be an in-memory database for tests
    static func setTestingTrue() {
        wishlistDAL = WishlistDAL(db: SQLiteDatabase.getInMemoryTestDatabase(), convert: convert)
    }
    
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
        guard let wishlistDAL = wishlistDAL else {
            return nil
        }
        return wishlistDAL.getAllWishlistProducts()
    }
    
    static func getByID(wishlistID: Int) -> [Wishlist]? {
        guard let wishlistDAL = wishlistDAL else {
            return nil
        }
        return wishlistDAL.getWishlistByID(wishlistID: wishlistID)
    }
    
    static func getByProductID(productID: Int) -> [Wishlist]? {
        guard let wishlistDAL = wishlistDAL else {
            return nil
        }
        return wishlistDAL.getWishlistByProductID(productID: productID)
    }
    
    static func removeByProductID(userID: Int, productID: Int) -> [Wishlist]? {
        guard let wishlistDAL = wishlistDAL else {
            return nil
        }
        return wishlistDAL.removeByProductID(userID: userID, productID: productID)
    }
    
    static func getByUserID(userID: Int) -> [Wishlist]? {
        guard let wishlistDAL = wishlistDAL else {
            return nil
        }
        return wishlistDAL.getWishlistByUserID(userID: userID)
    }
    
    static func create(userID: Int, productID: Int) -> Wishlist? {
        guard let wishlistDAL = wishlistDAL else {
            return nil
        }
        return wishlistDAL.createWishlistProduct(userID: userID, productID: productID)
    }
}
