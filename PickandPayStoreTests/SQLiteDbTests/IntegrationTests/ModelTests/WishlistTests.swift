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
        Product.setTestingTrue()
        Category.setTestingTrue()
        User.setTestingTrue()
    }

    // called after each test case
    override func tearDownWithError() throws {

    }
    
    // called after all tests have been run
        override func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(WishlistTests.inMemoryTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        }
    }
    
    func testWishlistCreate() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        let confirm_wishlist = Wishlist(id: 1, userID: created_user.id, productID: created_product.id, date_added: dateFormatterPrint.string(from: Date()))
        
        //When
        let new_wishlist = Wishlist.create(userID: created_user.id, productID: created_product.id)!
        
        //Then
        XCTAssert(confirm_wishlist == new_wishlist, "\(confirm_wishlist) and \(String(describing: new_wishlist)) should be equal")
    }
    
    func testWishlistGetAll() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        let wishlist_count = 3
        for x in 1...wishlist_count {
            Wishlist.create(userID: created_user.id, productID: created_product.id)
        }
        
        //When
        let query_count = Wishlist.getAll()!.count
        
        //Then
        XCTAssert(wishlist_count == query_count, "\(query_count) and \(wishlist_count) should be equal")
    }
    /*
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
