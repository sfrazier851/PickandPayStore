//
//  CategoryTests.swift
//
//  Created by iMac on 4/17/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class CategoryTests: XCTestCase {

    // initialize memory test database
    private static var inMemoryTestDB: OpaquePointer?
    
    // called before each test case
    override func setUpWithError() throws {
        CategoryTests.inMemoryTestDB = SQLiteDatabase.getInMemoryTestDatabase()
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: CategoryTests.inMemoryTestDB)
        // Set static var to use unit test db
        Category.setTestingTrue()
    }

    // called after each test case
    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override class func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(CategoryTests.inMemoryTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        }
    }
    
    func testCategoryCreate() throws {
        //Given
        let name = "new_category"
        let imageName = "new_image"
        let confirm_category = Category(id: 1, name: name, imageName: imageName)
        
        //When
        let new_category = Category.create(name: name, imageName: imageName)
        
        //Then
        XCTAssert(confirm_category == new_category, "\(confirm_category) and \(String(describing: new_category)) should be equal")
    }
    
    func testCategoryGetAll() throws {
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
    
    func testCategoryGetByID() throws {
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
    
    func testCategoryGetByName() throws {
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
}
