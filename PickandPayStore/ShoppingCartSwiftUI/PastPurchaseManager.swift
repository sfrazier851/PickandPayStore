//
//  PastOrdersManager.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/19/22.
//

import Foundation
import SwiftUI


class PastPurchaseManager: ObservableObject {
    
    @Published var purchaseOrders = [PurchaseOrder]()
    
    init(){
        if let userId = UserSessionManager.shared.getLoggedInUser()?.id {
            if let p =  PurchaseOrder.getByUserID(userID: 1){
                for purchaseOrder in p {
                    purchaseOrders.append(purchaseOrder)
                }
            }
        }
    }
    
    func getPastPurchases() -> [PurchaseOrder]{
        return self.purchaseOrders
    }
}


