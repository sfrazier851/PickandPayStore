//
//  ShoppingCartTests.swift
//  PickandPayStoreTests
//
//  Created by iMac on 4/20/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class ShoppingCartTests: XCTestCase {

    // initialize memory test database
    private static var inMemoryTestDB: OpaquePointer?
    
    // called before each test case
    override func setUpWithError() throws {
        ShoppingCartTests.inMemoryTestDB = SQLiteDatabase.getInMemoryTestDatabase()
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: ShoppingCartTests.inMemoryTestDB)
        // Set static var to use unit test db
        ShoppingCart.setTestingTrue()
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
        if sqlite3_close_v2(ShoppingCartTests.inMemoryTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        } else {
            print("\n==============")
            print("test db NOT closed")
            print("==============\n")
        }
    }
    
    func testShoppingCartCreate() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: date)
        
        let confirm_shopping_cart = ShoppingCart(id: 1, userID: created_user.id, productID: created_product.id, date_added: dateString)
        
        //When
        let new_shopping_cart = ShoppingCart.create(userID: created_user.id, productID: created_product.id)!
        
        //Then
        XCTAssert(confirm_shopping_cart == new_shopping_cart, "\(confirm_shopping_cart) and \(String(describing: new_shopping_cart)) should be equal")
    }
    
    func testShoppingCartGetAll() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        let shopping_cart_count = 3
        for x in 1...shopping_cart_count {
            ShoppingCart.create(userID: created_user.id, productID: created_product.id)
        }
        
        //When
        let query_count = ShoppingCart.getAll()!.count
        
        //Then
        XCTAssert(shopping_cart_count == query_count, "\(shopping_cart_count) and \(query_count) should be equal")
    }
    
    func testShoppingCartGetByID() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        
        let shopping_cart_query_id = 3
        var confirm_shopping_cart: ShoppingCart = ShoppingCart()
        for x in 1...shopping_cart_query_id {
            if x == shopping_cart_query_id {
                confirm_shopping_cart = ShoppingCart.create(userID: created_user.id, productID: created_product.id)!
            } else {
                ShoppingCart.create(userID: created_user.id, productID: created_product.id)
            }
        }
        
        //When
        let query_shopping_cart = ShoppingCart.getByID(shoppingCartID: shopping_cart_query_id)![0]
        
        //Then
        XCTAssert(confirm_shopping_cart == query_shopping_cart, "\(confirm_shopping_cart) and \(query_shopping_cart) should be equal")
    }
    
    func testShoppingCartGetByUserID() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_category = Category.create(name: "new_category", imageName: "category_image")!
        let created_product = Product.create(categoryID: created_category.id, name: "new_product", price: 0.0, imageName: "product_image", description: "product_description")!
        
        let shopping_cart_count = 3
        for x in 1...shopping_cart_count {
            ShoppingCart.create(userID: created_user.id, productID: created_product.id)
        }
        
        //When
        let query_count = ShoppingCart.getByUserID(userID: created_user.id)!.count
        
        //Then
        XCTAssert(shopping_cart_count == query_count, "\(shopping_cart_count) and \(query_count) should be equal")
    }
}
