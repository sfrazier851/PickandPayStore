//
//  User.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct User: Equatable {
    var id: Int = 0
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var phoneNumber: String = ""
    var balance: Float = 0.0
    
    private static var userDAL: UserDAL? = UserDAL(db: SQLiteDatabase.getDatabase(), convert: convert)
    
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
