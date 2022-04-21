//
//  ProductTests.swift
//  PickandPayStoreTests
//
//  Created by iMac on 4/20/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class ProductTests: XCTestCase {

    // initialize memory test database
    private static var inMemoryTestDB: OpaquePointer?
    
    // called before each test case
    override func setUpWithError() throws {
        ProductTests.inMemoryTestDB = SQLiteDatabase.getInMemoryTestDatabase()
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: ProductTests.inMemoryTestDB)
        // Set static var to use unit test db
        Product.setTestingTrue()
        Category.setTestingTrue()
    }

    // called after each test case
    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override class func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(ProductTests.inMemoryTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        }
    }
    
    func testProductCreate() throws {
        //Given
        let new_category = Category.create(name: "new_category", imageName: "image_name")!
        let confirm_product = Product(id: 1, categoryID: new_category.id, name: "product_name", price: 0.0, imageName: "image_name", description: "description")
        //When
        let new_product = Product.create(categoryID: new_category.id, name: confirm_product.name, price: confirm_product.price, imageName: confirm_product.imageName, description: confirm_product.description)
        //Then
        XCTAssert(confirm_product == new_product, "\(confirm_product) and \(String(describing: new_product)) should be equal")
    }
    
    func testProductGetByID() throws {
        //Given
        let new_category = Category.create(name: "new_category", imageName: "image_name")!
        let product_query_id = 3
        var confirm_product: Product = Product()
        let product_count = 3
        for x in 1...product_count {
            if(x == product_query_id) {
                confirm_product = Product.create(categoryID: new_category.id, name: "product_name\(x)", price: 0.0, imageName: "image_name\(x)", description: "description\(x)")!
            } else {
                Product.create(categoryID: new_category.id, name: "product_name\(x)", price: 0.0, imageName: "image_name\(x)", description: "description\(x)")
            }
        }
        
        //When
        let query_product = Product.getByID(productID: product_query_id)![0]
        
        //Then
        XCTAssert(confirm_product == query_product, "\(confirm_product) and \(String(describing: query_product)) should be equal")
    }
    
    func testProductGetByName() throws {
        //Given
        let new_category = Category.create(name: "new_category", imageName: "image_name")!
        let product_count = 3
        var confirm_product_name = "x-wing"
        var confirm_product: Product = Product()
        for x in 1...product_count {
            if(x == product_count) {
                confirm_product = Product.create(categoryID: new_category.id, name: confirm_product_name, price: 0.0, imageName: "image_name", description: "description")!
            } else {
                Product.create(categoryID: new_category.id, name: "product_name\(x)", price: 0.0, imageName: "image_name\(x)", description: "description\(x)")
            }
        }
        
        //When
        let query_product = Product.getByName(name: confirm_product_name)![0]
        
        //Then
        XCTAssert(confirm_product == query_product, "\(confirm_product) and \(String(describing: query_product)) should be equal")
    }
    
    func testUserGetAll() throws {
        //Given
        let new_category = Category.create(name: "new_category", imageName: "image_name")!
        let confirm_count = 3
        for x in 1...confirm_count {
            Product.create(categoryID: new_category.id, name: "product_name\(x)", price: 0.0, imageName: "image_name\(x)", description: "description\(x)")
        }
        
        //When
        let query_count = Product.getAll()!.count
        
        //Then
        XCTAssert(confirm_count == query_count, "\(confirm_count) and \(query_count) should be equal")
    }
}
