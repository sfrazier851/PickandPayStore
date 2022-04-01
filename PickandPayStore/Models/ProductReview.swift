//
//  ProductReview.swift
//  PickandPayStore
//
//  Created by iMac on 4/1/22.
//

import Foundation

struct ProductReview {
    var id: Int = 0
    var userID: Int = 0
    var productID: Int = 0
    var review: String = ""
    
    static let productreview = ProductReview()
    
    // Convert query result set to Array of ProductReview
    static func convert(productReviewsResultSet: [[String]]) -> [ProductReview]? {
        var productReviews = [ProductReview]()
        for productReview_row in productReviewsResultSet {
            let columns = productReview_row
            
            var productReview = ProductReview()
            productReview.id = Int(columns[0])!
            productReview.userID = Int(columns[1])!
            productReview.productID = Int(columns[2])!
            productReview.review = columns[3]
            
            productReviews.append(productReview)
        }
        return productReviews
    }
    
    /*
    static func getAll() -> [Wishlist]? {
        return SQLiteDAL.getAllWishlistProducts()
    }
    
    static func getByUserID(userID: Int) -> [Wishlist]? {
        return SQLiteDAL.getWishlistByUserID(userID: userID)
    }
    
    static func create(userID: Int, productID: Int) -> Bool? {
        return SQLiteDAL.createWishlistProduct(userID: userID, productID: productID)
    }
    */
}
