//
//  PurchaseDetailManager.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/20/22.
//

import Foundation
import SwiftUI

class PurchaseDetailManager{
    
    static let shared = PurchaseDetailManager()
    
    private init(){}
    
    // Add the private(set) to variables, so they can be set only within this class.
    @Published private(set) var products: [Product] = []
    
     private(set) var ordered: [OrderItem] = []
    
    
    func getItems(purchaseId: Int) -> [OrderItem]{
        
        if let p = OrderItem.getByPurchaseOrderID(purchaseOrderID: purchaseId){
            if self.ordered.count > 0
            {
                self.ordered = []
                for item in p{
                    self.ordered.append(item)
                }
            
            }
        }
        printArray(a: self.ordered)
        print(self.ordered.count)
        return self.ordered
    }
   
    
    
    func printArray(a: [Any]){
        for i in a {
            print(i)
        }
    }
}
