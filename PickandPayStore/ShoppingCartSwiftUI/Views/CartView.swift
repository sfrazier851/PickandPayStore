//
//  CartView.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import SwiftUI

struct CartView: View {
    
    // Environment object modifier of CartManager type.
    @Binding var productsInCart: [Product]
    @Binding var numberInCart: Int
    
    var body: some View {
        
        ScrollView {
            
            if productsInCart.count > 0
            {
                HStack {
                    Text("Your cart total is")
                    Spacer()
                    Text("$\(CartManager.sharedCart.total, specifier: "%.2f")")
                        .bold()
                }
                .padding()
                
                ForEach(productsInCart, id: \.id){
                    product in
                    ProductInCart(productsInCart: $productsInCart, numberInCart: $numberInCart, product: product)
                }
        
            }
            else
            {
                Text("Your cart is empty")
            }
            
        }
        .navigationTitle(Text("My Cart"))
        .padding(.top)
    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//            //.environmentObject(CartManager())
//    }
//}
