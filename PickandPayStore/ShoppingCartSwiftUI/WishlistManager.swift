//
//  WishlistManager.swift
//  PickandPayStore
//
//  Created by admin on 4/12/22.
//

import SwiftUI

class WishlistManager: ObservableObject {
    
    @Published private(set) var wishList: [Int:Int] = [:]
    
    init(){
        for i in 1...21{
            wishList[i] = 0
        }
        let userDefault = UserDefaults.standard
//        if let list = userDefault.object(forKey: "Wishlist")  {
//            wishList = list
//        }
        
    }
    
    func getWishList() -> [Int:Int]{
        return wishList
    }
    
}


