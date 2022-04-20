//
//  PurchaseDetailView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/20/22.
//

import SwiftUI

struct PurchaseDetailView: View {
    
    var purchaseId: Int
    
    @Binding var showThisView: Bool
    
    @StateObject var orderItems: PurchaseDetailManager = PurchaseDetailManager()
    
    var body: some View {
        
        VStack {
            
        }
    }
}

struct PurchaseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseDetailView(purchaseId:2, showThisView: .constant(true))
    }
}
