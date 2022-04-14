//
//  SQLiteDbUserTests.swift
//
//  Created by iMac on 4/1/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class SQLiteDbUserTests: XCTestCase {

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

    /*
    static func getAll() -> [User]? {

    
    static func getByID(userID: Int) -> [User]? {

    
    static func getByEmail(email: String) -> [User]? {

    
    static func getByUsername(username: String) -> [User]? {
    
    static func getNewlyCreated() -> [User]? {

    
    static func create(username: String, email: String, password: String, phoneNumber: String
    ) -> Bool? {
    */
    
    func testUserCreate() throws {
        //Given
        let username = "new_user"
        let email = "new_email"
        let password = "new_password"
        let phoneNumber = "3162755565"
        User.create(username: username, email: email, password: password, phoneNumber: phoneNumber)
        
        //When
        
        //Then
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
