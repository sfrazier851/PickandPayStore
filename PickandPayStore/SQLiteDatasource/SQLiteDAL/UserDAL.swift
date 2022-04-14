//
//  UserDAL.swift
//  PickandPayStore
//
//  Created by iMac on 4/14/22.
//

import Foundation
import SQLite3

class UserDAL: SQLiteDAL {
        
    private let user = User()
    private let db: OpaquePointer?
    private let convert: (_ usersResultSet: [[String]]) -> [User]?
    
    init(db: OpaquePointer?, convert: @escaping (_ usersResultSet: [[String]]) -> [User]?) {
        self.convert = convert
        self.db = db
        super.init(db: db)
    }
    
    // User DAL (getAllUsers, getUsersByEmail, createUser)
    func getAllUsers() -> [User]? {
        guard let usersResultSet = UserDAL.protectedQuery(modelType: user, queryString: "SELECT * FROM User;") else {
            return nil
        }
        return self.convert(usersResultSet)
    }
    
    func getUserByID(userID: Int) -> [User]? {
        guard let usersResultSet = UserDAL.protectedQuery(modelType: user, queryString: "SELECT * FROM User WHERE ID = '\(userID)';") else {
            return nil
        }
        return self.convert(usersResultSet)
    }
    
    func getUsersByEmail(email: String) -> [User]? {
        guard let usersResultSet = UserDAL.protectedQuery(modelType: user, queryString: "SELECT * FROM User WHERE email = '\(email)';") else {
            return nil
        }
        return self.convert(usersResultSet)
    }
    
    func getUsersByUsername(username: String) -> [User]? {
        guard let usersResultSet = UserDAL.protectedQuery(modelType: user, queryString: "SELECT * FROM User WHERE username = '\(username)';") else {
            return nil
        }
        return self.convert(usersResultSet)
    }
    
    func createUser(username: String, email: String, password: String, phoneNumber: String) -> User? {
        guard let db = self.db else {
            return nil
        }
        let insertStatementString = "INSERT INTO User ( username, email, password, phone_number, balance ) VALUES ( ?, ?, ?, ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, NSString(string: username).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, NSString(string: email).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, NSString(string: password).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, NSString(string: phoneNumber).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 5, Double(0.0))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\nINSERT statement is not prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
        
        let newUserID = UserDAL.protectedGetLatestInsertId()!
        return User.getByID(userID: newUserID)![0]
    }
    
}
