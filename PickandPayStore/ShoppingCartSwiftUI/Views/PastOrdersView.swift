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
            
            VStack(alignment: .leading){
                Text("Date: \(purchase.date_purchased)")
                    .fontWeight(.bold)
                Text("Address : \(purchase.shipping_address)")
                    .fontWeight(.light)
            }
            .frame(alignment: .leading)
            .padding()
            
            
        }
        .navigationTitle("Past Purchases")
        
    }
}

struct PastOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        PastOrdersView()
    }
}
