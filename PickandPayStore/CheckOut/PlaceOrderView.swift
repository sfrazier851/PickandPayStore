//
//  PlaceOrderView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct PlaceOrderView: View {
    
    @Binding var productsInOrder : [Product]
    @Binding var userId : Int
    @Binding  var paymentSelected : String
    @Binding var shippmentAdress : String
    
    
    func createOrderItems(productsInOrder: [Product], purchaseOrder: PurchaseOrder){
        for product in productsInOrder{
            OrderItem.create(purchaseOrderID: purchaseOrder.id, productID: product.id, purchasePrice: product.price)
        }
    }
    
    var body: some View {
        Button(action:{
            
            let order = PurchaseOrder.create(userID: userId, paymentType: paymentSelected, shippingAddress: shippmentAdress)
            createOrderItems(productsInOrder: productsInOrder, purchaseOrder: order!)
           
        },label: {
            Text("Place Order")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
        })
        .padding(20)
        
    }
}

/*struct PlaceOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceOrderView()
    }
}*/
