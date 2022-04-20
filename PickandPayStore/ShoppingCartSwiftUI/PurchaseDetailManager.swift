//
//  PurchaseDetailManager.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/20/22.
//

import Foundation
import SwiftUI

class PurchaseDetailManager: ObservableObject{

    var orderedItems = [Int]()
    
    @Published var orderedProducts = [Product]()

    init(){}

    func getItems(purchaseId: Int) -> [Product]{
        
        fillOrderedItems(purchaseId: purchaseId)
        
        for order in self.orderedItems{
            
            if let product = Product.getByID(productID: order){
                for p in product{
                    self.orderedProducts.append(p)
                }
            }
        }
        return self.orderedProducts
    }
    
    
    
    func fillOrderedItems(purchaseId: Int){
        if let order = OrderItem.getByPurchaseOrderID(purchaseOrderID: purchaseId){
            for orderedItem in order{
                self.orderedItems.append(orderedItem.productID)
            }
        }
        
    }
}
