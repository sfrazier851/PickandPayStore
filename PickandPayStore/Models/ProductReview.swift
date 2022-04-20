//
//  ProductReview.swift
//  PickandPayStore
//
//  Created by iMac on 4/1/22.
//

import Foundation

struct ProductReview: Equatable {
    var id: Int = 0
    var userID: Int = 0
    var productID: Int = 0
    var review: String = ""
    
    static func setTestingTrue() {
        productReviewDAL = ProductReviewDAL(db: SQLiteDatabase.getInMemoryTestDatabase(), convert: convert)
    }
    
    private static var productReviewDAL: ProductReviewDAL? = ProductReviewDAL(db: SQLiteDatabase.getDatabase(), convert: convert)
    
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
    
    static func getAll() -> [ProductReview]? {
        guard let productReviewDAL = productReviewDAL else {
            return nil
        }
        return productReviewDAL.getAllProductReviews()
    }
    
    static func getByID(productReviewID: Int) -> [ProductReview]? {
        guard let productReviewDAL = productReviewDAL else {
            return nil
        }
        return productReviewDAL.getProductReviewByID(productReviewID: productReviewID)
    }
    
    static func getByProductID(productID: Int) -> [ProductReview]? {
        guard let productReviewDAL = productReviewDAL else {
            return nil
        }
        return productReviewDAL.getReviewsByProductID(productID: productID)
    }
    
    static func create(userID: Int, productID: Int, review: String) -> ProductReview? {
        guard let productReviewDAL = productReviewDAL else {
            return nil
        }
        return productReviewDAL.createProductReview(userID: userID, productID: productID, review: review)
    }
}
