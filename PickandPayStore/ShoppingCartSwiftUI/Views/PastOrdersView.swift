//
//  PastOrdersView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/19/22.
//

import SwiftUI

struct PastOrdersView: View {
    
    @StateObject var pastPurchases: PastPurchaseManager = PastPurchaseManager()
    
    @State var showDetails: Bool = false
    
    var body: some View {
        
        
        ZStack {
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
                    
                    
                        Button(action: {
                            
                            showDetails.toggle()
                        }, label: {
                            Text("Details")
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                            
                        })
                        .frame(width: 100, height: 50)
                        .border(.green, width: 2)
                    }
                    
                    showDetails ? PurchaseDetailView(purchaseId: purchase.id, showThisView: $showDetails) : nil
                }
            .navigationTitle("Past Purchases")
        }
        
    }
}

struct PastOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        PastOrdersView()
    }
}
