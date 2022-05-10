//
//  User.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

// User Model is for all Database operations for the User entity.
// NOTE: the order of public properties matters and MUST match the order of columns
//   in the database table definition.
struct User: Equatable {
    var id: Int = 0
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var phoneNumber: String = ""
    var balance: Float = 0.0
    
    // pass in the database for the application
    private static var userDAL: UserDAL? = UserDAL(db: SQLiteDatabase.getDatabase(), convert: convert)
    
    // set the database to be an in-memory database for tests
    static func setTestingTrue() {
        User.userDAL = UserDAL(db: SQLiteDatabase.getInMemoryTestDatabase(), convert: convert)
    }
    
    // Convert user result set to Array of User
    private static func convert(usersResultSet: [[String]]) -> [User]? {
        var users = [User]()
        for user_row in usersResultSet {
            let columns = user_row
            
            var user = User()
            user.id = Int(columns[0])!
            user.username = columns[1]
            user.email = columns[2]
            user.password = columns[3]
            user.phoneNumber = columns[4]
            user.balance = Float(columns[5])!
            
            users.append(user)
        }
        return users
    }
    
    // User queries and creation
    static func getAll() -> [User]? {
        guard let userDAL = userDAL else {
            return nil
        }
        return userDAL.getAllUsers()
    }
    
    static func getByID(userID: Int) -> [User]? {
        guard let userDAL = userDAL else {
            return nil
        }
        return userDAL.getUserByID(userID: userID)
    }
    
    static func getByEmail(email: String) -> [User]? {
        guard let userDAL = userDAL else {
            return nil
        }
        return userDAL.getUsersByEmail(email: email)
    }
    
    static func getByUsername(username: String) -> [User]? {
        guard let userDAL = userDAL else {
            return nil
        }
        return userDAL.getUsersByUsername(username: username)
    }
    
    static func create(username: String, email: String, password: String, phoneNumber: String
    ) -> User? {
        guard let userDAL = userDAL else {
            return nil
        }
        return userDAL.createUser(username: username, email: email, password: password, phoneNumber: phoneNumber)
    }
}
