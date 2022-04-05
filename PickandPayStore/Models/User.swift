//
//  User.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct User {
    var id: Int = 0
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var phoneNumber: String = ""
    var balance: Float = 0.0
    
    static let user = User()
    
    // Convert user result set to Array of User
    static func convert(usersResultSet: [[String]]) -> [User]? {
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
        return SQLiteDAL.getAllUsers()
    }
    
    static func getByID(userID: Int) -> [User]? {
        return SQLiteDAL.getUserByID(userID: userID)
    }
    
    static func getByEmail(email: String) -> [User]? {
        return SQLiteDAL.getUsersByEmail(email: email)
    }
    
    static func getByUsername(username: String) -> [User]? {
        return SQLiteDAL.getUsersByUsername(username: username)
    }
    
    static func create(username: String, email: String, password: String, phoneNumber: String
    ) -> Bool? {
        return SQLiteDAL.createUser(username: username, email: email, password: password, phoneNumber: phoneNumber)
    }
}
