//
//  PurchaseDetailView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/20/22.
//

import SwiftUI

struct PurchaseDetailView: View {
    
    var purchaseId: Int
    @ObservedObject var pastPurchases: PastPurchaseManager
    
    var body: some View {
            
        
        VStack {
            
               VStack {
                   List(pastPurchases.getPurchasedProducts(purchaseId: purchaseId), id: \.id) { product in
                       ProductInOrderView(product: Product.getByID(productID: product.productID)!)
                    }
                    //.navigationTitle("Details")
                }
                .navigationTitle("Details")
        }
       // .navigationTitle("Details")
        
    }
}

//struct PurchaseDetailView_Previews: PreviewProvider {
   // static var previews: some View {
   //     PurchaseDetailView(purchaseId:1)
   // }
//}
