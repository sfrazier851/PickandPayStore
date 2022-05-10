//
//  ProductReviewDAL.swift
//  PickandPayStore
//
//  Created by iMac on 4/14/22.
//

import Foundation
import SQLite3

class ProductReviewDAL: SQLiteDAL {
        
    private let productreview = ProductReview()
    private let db: OpaquePointer?
    // function defined in corresponding model struct
    private let convert: (_ productReviewResultSet: [[String]]) -> [ProductReview]?
    
    init(db: OpaquePointer?, convert: @escaping (_ productReviewResultSet: [[String]]) -> [ProductReview]?) {
        self.convert = convert
        self.db = db
        super.init(db: db)
    }

    // ProductReview DAL (getAllProductReviews, getReviewsByProductID, createProductReview)
    func getAllProductReviews() -> [ProductReview]? {
        guard let productReviewsResultSet = ProductReviewDAL.protectedQuery(modelType: productreview, queryString: "SELECT * FROM ProductReview;") else {
            return nil
        }
        return self.convert(productReviewsResultSet)
    }
    
    func getProductReviewByID(productReviewID: Int) -> [ProductReview]? {
        guard let productReviewsResultSet = ProductReviewDAL.protectedQuery(modelType: productreview, queryString: "SELECT * FROM ProductReview WHERE ID = '\(productReviewID)';") else {
            return nil
        }
        return self.convert(productReviewsResultSet)
    }

    func getReviewsByProductID(productID: Int) -> [ProductReview]? {
        guard let productReviewsResultSet = ProductReviewDAL.protectedQuery(modelType: productreview, queryString: "SELECT * FROM ProductReview WHERE productID = '\(productID)';") else {
            return nil
        }
        return self.convert(productReviewsResultSet)
    }

    func createProductReview(userID: Int, productID: Int, review: String, title: String) -> ProductReview? {
        guard let db = self.db else {
            return nil
        }
        let insertStatementString = "INSERT INTO ProductReview ( userID, productID, review, title ) VALUES ( ?, ?, ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(userID))
            sqlite3_bind_int(insertStatement, 2, Int32(productID))
            sqlite3_bind_text(insertStatement,3, NSString(string: review).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement,4, NSString(string: title).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
        
        let newProductReviewID = ProductReviewDAL.protectedGetLatestInsertId()!
        return ProductReview.getByID(productReviewID: newProductReviewID)![0]
    }
}
