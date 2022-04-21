//
//  PastOrdersView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/19/22.
//

import SwiftUI

struct PastOrdersView: View {
    
    @StateObject var pastPurchases: PastPurchaseManager = PastPurchaseManager()
    
    
    var body: some View {
        
        
    
            List(pastPurchases.getPastPurchases(), id: \.id) { purchase in
                
                HStack {
                        VStack(alignment: .leading){
                                Text("Date: \(purchase.date_purchased)")
                                    .fontWeight(.bold)
                                Text("Payment: \(purchase.paymentType)")
                                    .fontWeight(.light)
                                Text("Address : \(purchase.shipping_address)")
                                    .fontWeight(.light)
                                Spacer()
                            
                        }
                        .frame(alignment: .leading)
                        .padding()
                    
                    NavigationLink(destination: PurchaseDetailView(purchaseId: purchase.id, pastPurchases: pastPurchases)){
                        Text("Details")
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 130, height: 50)
                    .border(.green, width: 2)
                    
                   
            }.navigationTitle("Past Purchases")
        }
        
    }
}

struct PastOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        PastOrdersView()
    }
}
