//
//  SessionManager.swift
//  PickandPayStore
//
//  Created by iMac on 4/7/22.
//

import Foundation

class UserSessionManager {
    
    static let shared = UserSessionManager()
    
    private init() {}
    
    private static var loggedInUser: User?
    
    func setLoggedInUser(user: User) {
        UserSessionManager.loggedInUser = user
    }
    
    func getLoggedInUser() -> User? {
        guard let user = UserSessionManager.loggedInUser else {
            return nil
        }
        return user
    }
    
}
