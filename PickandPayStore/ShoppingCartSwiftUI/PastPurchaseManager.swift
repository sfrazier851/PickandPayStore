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
    @Published var orderedItems = [OrderItem]()
    @Published var orderedProducts = [Product]()
    
   private var orderedByPurchaseId = [OrderItem]()
    
    init(){
        if let userId = UserSessionManager.shared.getLoggedInUser()?.id {
            if let p =  PurchaseOrder.getByUserID(userID: 1){
                for purchaseOrder in p {
                    purchaseOrders.append(purchaseOrder)
                }
            }
        }
        
        for p in self.purchaseOrders{
            
            if let orderItems = OrderItem.getByPurchaseOrderID(purchaseOrderID: p.id){
                for item in orderItems{
                    self.orderedItems.append(item)
                }
            }
        }
    }
    
    func getPastPurchases() -> [PurchaseOrder]{
        return self.purchaseOrders
    }
    
    func getOrderedItems() -> [OrderItem]{
        print(self.orderedItems)
        return self.orderedItems
    }
    
    func getPurchasedProducts(purchaseId: Int) -> [OrderItem]{
        
        orderedByPurchaseId = self.orderedItems.filter{$0.purchaseOrderID == purchaseId}
        print(self.orderedByPurchaseId)
        return self.orderedByPurchaseId
    }
}


