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
    private static var isLoggedIn: Bool = false
    
    func setLoggedInUser(user: User) {
        UserSessionManager.loggedInUser = user
        UserSessionManager.isLoggedIn = true
        
    }
    
    func getLoggedInUser() -> User? {
        guard let user = UserSessionManager.loggedInUser else {
            return nil
        }
        return user
    }
    
    func isLoggedIn() -> Bool{
            return UserSessionManager.isLoggedIn
        }
        
        func getUserName() -> String{
            return getLoggedInUser()?.username ?? "no user"
        }
        
        func setLoggedInFalse(){
            UserSessionManager.isLoggedIn = false
        }
        
}
