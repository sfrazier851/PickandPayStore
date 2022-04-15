//
//  SQLiteDbTests.swift
//
//  Created by iMac on 4/1/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class UserTests: XCTestCase {

    // initialize unit test database
    private static let unitTestDB = SQLiteDatabase.getUnitTestDatabase()
    
    // called before each test case
    override func setUpWithError() throws {
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: UserTests.unitTestDB)
        // Set static var to use unit test db
        User.setTestingTrue()
    }

    // called after each test case
    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override class func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(UserTests.unitTestDB!) == 0 {
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

    
    static func create(username: String, email: String, password: String, phoneNumber: String
    ) -> User? {
    */
    
    func testUserCreate() throws {
        //Given
        let username = "new_user"
        let email = "new_email"
        let password = "new_password"
        let phoneNumber = "3162755565"
        let confirm_user = User(id: 1, username: username, email: email, password: password, phoneNumber: phoneNumber, balance: 0.0)
        
        //When
        let new_user = User.create(username: username, email: email, password: password, phoneNumber: phoneNumber)
        
        //Then
        XCTAssert(confirm_user == new_user, "\(confirm_user) and \(String(describing: new_user)) should be equal")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
