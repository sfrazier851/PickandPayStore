//
//  DbMemory.swift
//
//  Created by iMac on 4/1/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class DbInMemory: XCTestCase {

    // initialize memory test database
    private static var inMemoryTestDB: OpaquePointer?
    
    // called before each test case
    override func setUpWithError() throws {
        DbInMemory.inMemoryTestDB = SQLiteDatabase.getInMemoryTestDatabase()
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: DbInMemory.inMemoryTestDB)

    }

    // called after each test case
    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override class func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(DbInMemory.inMemoryTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        }
        
    }
    
    func testCreateDbInMemory() throws {
        //Given
        //When
        let result = SQLiteDatabase.getDbURLString(database: DbInMemory.inMemoryTestDB)
        //Then
        XCTAssertTrue(result == "", "\(String(describing: result)) should be empty string")
    }
}
