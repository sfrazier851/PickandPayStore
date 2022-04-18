//
//  DbFile.swift
//
//  Created by iMac on 4/1/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class DbFile: XCTestCase {

    // initialize file test database
    private static let fileTestDB = SQLiteDatabase.getTestDatabase()
    
    // called before each test case
    override func setUpWithError() throws {
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: DbFile.fileTestDB)
    }

    // called after each test case
    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override class func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(DbFile.fileTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        }
    }

    
    func testCreateDbFile() throws {
        //Given
        //When
        let fileTestDbPath = URL(string: SQLiteDatabase.getDbURLString(database: DbFile.fileTestDB)!)!.path
        //Then
        XCTAssertTrue(FileManager.default.fileExists(atPath: fileTestDbPath))
    }
}
