//
//  SQLiteDbTests.swift
//
//  Created by iMac on 4/1/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class SQLiteDbTests: XCTestCase {

    // initialize test database
    private static let testDB = SQLiteDatabase.getTestDatabase()
    
    override func setUpWithError() throws {
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: SQLiteDbTests.testDB)
    }

    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override class func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(SQLiteDbTests.testDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
