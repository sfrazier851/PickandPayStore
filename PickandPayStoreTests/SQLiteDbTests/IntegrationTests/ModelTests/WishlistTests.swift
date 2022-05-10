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

    // (in-memory) test database
    private static var inMemoryTestDB: OpaquePointer?
    
    // called before each test case
    override func setUpWithError() throws {
        WishlistTests.inMemoryTestDB = SQLiteDatabase.getInMemoryTestDatabase()
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: WishlistTests.inMemoryTestDB)
        // use in-memory db for testing
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
        } else {
            print("\n==============")
            print("test db NOT closed")
            print("==============\n")
        }
    }
    
    func testWishlistCreate() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: date)
        
        let confirm_wishlist = Wishlist(id: 1, userID: created_user.id, productID: created_product.id, date_added: dateString)
        
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
    
    func testWishlistGetByID() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        
        let wishlist_query_id = 3
        var confirm_wishlist: Wishlist = Wishlist()
        for x in 1...wishlist_query_id {
            if x == wishlist_query_id {
                confirm_wishlist = Wishlist.create(userID: created_user.id, productID: created_product.id)!
            } else {
                Wishlist.create(userID: created_user.id, productID: created_product.id)
            }
        }
        
        //When
        let query_wishlist = Wishlist.getByID(wishlistID: wishlist_query_id)![0]
        
        //Then
        XCTAssert(confirm_wishlist == query_wishlist, "\(confirm_wishlist) and \(query_wishlist) should be equal")
    }
    
    func testWishlistGetByUserID() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        
        let wishlist_count = 3
        for x in 1...wishlist_count {
            Wishlist.create(userID: created_user.id, productID: created_product.id)
        }
        
        //When
        let query_count = Wishlist.getByUserID(userID: created_user.id)!.count
        
        //Then
        XCTAssert(wishlist_count == query_count, "\(wishlist_count) and \(query_count) should be equal")
    }
}
