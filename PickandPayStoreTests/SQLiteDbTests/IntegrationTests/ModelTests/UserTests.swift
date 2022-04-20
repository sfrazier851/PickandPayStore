//
//  UserTests.swift
//
//  Created by iMac on 4/1/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class UserTests: XCTestCase {

    // initialize memory test database
    private static var inMemoryTestDB: OpaquePointer?
    
    // called before each test case
    override func setUpWithError() throws {
        UserTests.inMemoryTestDB = SQLiteDatabase.getInMemoryTestDatabase()
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: UserTests.inMemoryTestDB)
        // Set static var to use unit test db
        User.setTestingTrue()
    }

    // called after each test case
    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override class func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(UserTests.inMemoryTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        }
    }
    
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
    
    func testUserGetByUsername() throws {
        //Given
        let user_query_id = 3
        var confirm_user: User = User()
        let user_count = 3
        for x in 1...user_count {
            if(x == user_query_id) {
                confirm_user = User.create(username: "username\(x)", email: "email\(x)", password: "password\(x)", phoneNumber: "phonenumber\(x)")!
            } else {
                User.create(username: "username\(x)", email: "email\(x)", password: "password\(x)", phoneNumber: "phonenumber\(x)")
            }
        }
        
        //When
        let query_user = User.getByUsername(username: "username\(user_query_id)")![0]
        
        //Then
        XCTAssert(confirm_user == query_user, "\(confirm_user) and \(String(describing: query_user)) should be equal")
    }
    
    func testUserGetByEmail() throws {
        //Given
        let user_query_id = 3
        var confirm_user: User = User()
        let user_count = 3
        for x in 1...user_count {
            if(x == user_query_id) {
                confirm_user = User.create(username: "username\(x)", email: "email\(x)", password: "password\(x)", phoneNumber: "phonenumber\(x)")!
            } else {
                User.create(username: "username\(x)", email: "email\(x)", password: "password\(x)", phoneNumber: "phonenumber\(x)")
            }
        }
        
        //When
        let query_user = User.getByEmail(email: "email\(user_query_id)")![0]
        
        //Then
        XCTAssert(confirm_user == query_user, "\(confirm_user) and \(String(describing: query_user)) should be equal")
    }
    
    func testUserGetByID() throws {
        //Given
        let user_query_id = 3
        var confirm_user: User = User()
        let user_count = 3
        for x in 1...user_count {
            if(x == user_query_id) {
                confirm_user = User.create(username: "username\(x)", email: "email\(x)", password: "password\(x)", phoneNumber: "phonenumber\(x)")!
            } else {
                User.create(username: "username\(x)", email: "email\(x)", password: "password\(x)", phoneNumber: "phonenumber\(x)")
            }
        }
        
        //When
        let query_user = User.getByID(userID: user_query_id)![0]
        
        //Then
        XCTAssert(confirm_user == query_user, "\(confirm_user) and \(String(describing: query_user)) should be equal")
    }
    
    func testUserGetAll() throws {
        //Given
        let user_count = 3
        for x in 1...user_count {
            User.create(username: "username\(x)", email: "email\(x)", password: "password\(x)", phoneNumber: "phonenumber\(x)")
        }
        
        //When
        let query_count = User.getAll()!.count
        
        //Then
        XCTAssert(user_count == query_count, "\(query_count) and \(user_count) should be equal")
    }
}
