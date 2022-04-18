//
//  WishlistTests.swift
//  PickandPayStoreTests
//
//  Created by iMac on 4/18/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class WishlistTests: XCTestCase {

    // initialize memory test database
    private static let inMemoryTestDB = SQLiteDatabase.getInMemoryTestDatabase()
    
    // called before each test case
    override func setUpWithError() throws {
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: WishlistTests.inMemoryTestDB)
        // Set static var to use unit test db
        Wishlist.setTestingTrue()
    }

    // called after each test case
    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override class func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(WishlistTests.inMemoryTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        }
    }
    /*
    func testWishlistCreate() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        let userID: Int = 0
        let productID: Int = 0
        let date_added: String = ""
        let confirm_wishlist = Wishlist(id: 1, userID: created_user.id, productID: created_product.id, date_added: String(Date()!))
        
        //When
        let new_category = Category.create(name: name, imageName: imageName)
        
        //Then
        XCTAssert(confirm_category == new_category, "\(confirm_category) and \(String(describing: new_category)) should be equal")
    }
    
    func testWishlistGetAll() throws {
        //Given
        let category_count = 3
        for x in 1...category_count {
            Category.create(name: "name\(x)", imageName: "image\(x)")
        }
        
        //When
        let query_count = Category.getAll()!.count
        
        //Then
        XCTAssert(category_count == query_count, "\(query_count) and \(category_count) should be equal")
    }
    
    func testWishlistGetByID() throws {
        //Given
        let category_query_id = 3
        var confirm_category = Category()
        let category_count = 3
        for x in 1...category_count {
            if(x == category_query_id) {
                confirm_category = Category.create(name: "name\(x)", imageName: "image\(x)")!
            } else {
                Category.create(name: "name\(x)", imageName: "image\(x)")
            }
        }
        
        //When
        let query_category = Category.getByID(categoryID: category_query_id)![0]
        
        //Then
        XCTAssert(confirm_category == query_category, "\(confirm_category) and \(String(describing: query_category)) should be equal")
    }
    
    func testWishlistGetByUserID() throws {
        //Given
        let category_query_id = 3
        var confirm_category = Category()
        let category_count = 3
        for x in 1...category_count {
            if(x == category_query_id) {
                confirm_category = Category.create(name: "name\(x)", imageName: "image\(x)")!
            } else {
                Category.create(name: "name\(x)", imageName: "image\(x)")
            }
        }
        
        //When
        let query_category = Category.getByName(name: "name\(category_query_id)")![0]
        
        //Then
        XCTAssert(confirm_category == query_category, "\(confirm_category) and \(String(describing: query_category)) should be equal")
    }
    */
}
