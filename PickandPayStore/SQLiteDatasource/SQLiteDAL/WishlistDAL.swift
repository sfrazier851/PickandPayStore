//
//  WishlistDAL.swift
//  PickandPayStore
//
//  Created by iMac on 4/14/22.
//

import Foundation
import SQLite3

class WishlistDAL: SQLiteDAL {
        
    private let wishlist = Wishlist()
    private let db: OpaquePointer?
    // function defined in corresponding model struct
    private let convert: (_ wishlistResultSet: [[String]]) -> [Wishlist]?
    
    init(db: OpaquePointer?, convert: @escaping (_ wishlistResultSet: [[String]]) -> [Wishlist]?) {
        self.convert = convert
        self.db = db
        super.init(db: db)
    }

    // Wishlist DAL (getAllWishlistProducts, getWishlistByUserID, createWishlistProduct)
    func getAllWishlistProducts() -> [Wishlist]? {
        guard let wishlistProductsResultSet = WishlistDAL.protectedQuery(modelType: wishlist, queryString: "SELECT * FROM Wishlist;") else {
            return nil
        }
        return self.convert(wishlistProductsResultSet)
    }
    
    func getWishlistByID(wishlistID: Int) -> [Wishlist]? {
        guard let wishlistProductsResultSet = WishlistDAL.protectedQuery(modelType: wishlist, queryString: "SELECT * FROM Wishlist WHERE ID = '\(wishlistID)';") else {
            return nil
        }
        return self.convert(wishlistProductsResultSet)
    }
    
    func getWishlistByProductID(productID: Int) -> [Wishlist]? {
        guard let wishlistProductsResultSet = WishlistDAL.protectedQuery(modelType: wishlist, queryString: "SELECT * FROM Wishlist WHERE productID = '\(productID)';") else {
            return nil
        }
        return self.convert(wishlistProductsResultSet)
    }
    
    func removeByProductID(userID: Int, productID: Int) -> [Wishlist]? {
        guard let wishlistProductsResultSet = WishlistDAL.protectedQuery(modelType: wishlist, queryString: "DELETE FROM Wishlist WHERE productID = '\(productID)' AND userID = '\(userID)';") else {
            return nil
        }
        return self.convert(wishlistProductsResultSet)
    }
    
    func getWishlistByUserID(userID: Int) -> [Wishlist]? {
        guard let wishlistProductsResultSet = WishlistDAL.protectedQuery(modelType: wishlist, queryString: "SELECT * FROM Wishlist WHERE userID = '\(userID)';") else {
            return nil
        }
        return self.convert(wishlistProductsResultSet)
    }
    
    func createWishlistProduct(userID: Int, productID: Int) -> Wishlist? {
        guard let db = self.db else {
            return nil
        }
        let insertStatementString = "INSERT INTO Wishlist ( userID, productID ) VALUES ( ?, ? )"
        
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

        let newWishlistID = WishlistDAL.protectedGetLatestInsertId()!
        return Wishlist.getByID(wishlistID: newWishlistID)![0]
    }
}
