//
//  CheckOutView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct CheckOutView: View {
  
    
    
    @State var productsInCar: [Product] = []
    @State var userLoggedIn: User = UserSessionManager.shared.getLoggedInUser()!
    
    
    @State var subtotal: Float = 0
    @State var paymentSelected = ""
    @State var shipment = "233 Ny 11411"
    @State var adrees = ""
    @State var postalCode = ""
    @State var state = ""
    
    @State var success = CartManager.sharedCart.paymentSucces
    
    
    
    var body: some View {
        NavigationView{
            
            VStack{
                
               if success{
                  Text("Payment succes")
                 
                }else{
                
                List{
                    Section{
                        
                        Text("Summary")
                             .font(.title)
                             .fontWeight(.bold)
                             .foregroundColor(.blue)
                        SummaryOrderView()
                             .padding()
                    }
                   //Section
                    
                   //Select payment
                    SelectPaymentView(paymentSelected: $paymentSelected, success: $success)
                        .frame(height: 150)
                    
                  //  ApplePayButtonView(action: CartManager.sharedCart.pay)
                   //Shipping Section
                   // ShippingButtonView(adress: $adrees, postalCode: $postalCode, state: $state)
                   //     .frame(height: 200)
                    
                        
                  //Place order
                    PlaceOrderView(productsInOrder: $productsInCar, userId: $userLoggedIn.id, success: $success, paymentSelected: $paymentSelected, shippmentAdress: $shipment)
                        
                    
                            
                        
                    }
                    //List
              }
               //if else
               
            }
           //Vstack
            .onAppear{
                productsInCar = CartManager.sharedCart.products
                if success {
                   success = false
                }
            }
        
        }
    }
    
    func createOrderItems(productsInOrder: [Product], purchaseOrder: PurchaseOrder) -> Bool{
        for product in productsInOrder{
            OrderItem.create(purchaseOrderID: purchaseOrder.id, productID: product.id, purchasePrice: product.price)
            print("product item \(product.name)")
        }
        return true
    }
  
    func getSubTotal(products: [Product]) -> Float{
        var total: Float = 0.0
        for index in 0..<products.count{
            
            total += products[index].price
        }
        
        return total
    }
    
    func calculateTaxes(products: [Product]) -> Float{
        return getSubTotal(products: products) * 0.03
    }
    
    func getTotal(products: [Product]) -> Float{
        return getSubTotal(products: products) + calculateTaxes(products: products)
    }
       
}






struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CheckOutView()
           
        }
    }
}
