//
//  CartView.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import SwiftUI

struct CartView: View {
    
    // The check if the client is logged in.
    @State var isLoggedIn: Bool = UserSessionManager.shared.isLoggedIn()
    
    // This state variable controlls the display of the NotRegisteredNotification.
    @State var displayNotification: Bool = false
    
    //flag to display checkoutview
   // @State var displayCheckout = true
    
    
    // Environment object modifier of CartManager type.
    @State var productsInCart: [Product] = []
    @State var numberInCart: Int = 0
    
    var body: some View {
        
        ZStack {
            ScrollView {
                
                if productsInCart.count > 0
                {
                    VStack {
                        HStack {
                            Text("Your cart total is")
                            Spacer()
                            Text("$\(CartManager.sharedCart.total, specifier: "%.2f")")
                                .bold()
                        }
                        .padding()
                        
                        HStack {
                            Button ( action: {
                                
                                
                                displayNotification.toggle()
                              //  displayCheckout.toggle()
                                
                                
                            }, label: {
                                Text("Check Out")
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                    .padding()
                                    .border(.red, width: 2)
                                })
                            .padding()
                            
                            Spacer()
                        }
                        
                    }
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
            .navigationTitle(isLoggedIn && displayNotification ? Text("Order"): Text("My Cart")  )
            .padding(.top)
            .onAppear(){
                productsInCart = CartManager.sharedCart.products
                numberInCart = CartManager.sharedCart.products.count
            }
    
         //   displayNotification ? NotRegisteredNotification() : nil
            
            if isLoggedIn && displayNotification{
                CheckOutView()
            }else if displayNotification{
              
                NotRegisteredNotification()            }
            
        }
    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//            //.environmentObject(CartManager())
//    }
//}
