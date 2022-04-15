//
//  SQLiteDbTests.swift
//
//  Created by iMac on 4/1/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class DbIntegration: XCTestCase {

    // initialize unit test database
    private static let integrationTestDB = SQLiteDatabase.getIntegrationTestDatabase()
    
    // called before each test case
    override func setUpWithError() throws {
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: DbIntegration.integrationTestDB)
    }

    // called after each test case
    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override class func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(DbIntegration.integrationTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        }
    }
    
    func testCreateDbFile() throws {
        //Given
        //When
        let integrationDbPath = SQLiteDatabase.getIntegrationTestDbPath()
        //Then
        XCTAssertTrue(FileManager.default.fileExists(atPath: integrationDbPath))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
