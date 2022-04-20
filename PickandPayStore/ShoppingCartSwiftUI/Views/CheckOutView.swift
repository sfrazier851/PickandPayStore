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
    
    
    
    var body: some View {
        NavigationView{
            
            VStack{
                
               if CartManager.sharedCart.paymentSucces{
                  Text("Payment succes")
                   let order = PurchaseOrder.create(userID: userLoggedIn.id, paymentType: "Apple pay", shippingAddress: shipment)
                   
                   let succes = createOrderItems(productsInOrder: productsInCar, purchaseOrder: order!)
                   
                   
                 /*  ForEach(productsInCar, id: \.id){ product in
                       OrderItem.create(purchaseOrderID: order.id, productID: product.id, purchasePrice: product.price)
                       
                   }*/
                   
                   
                 
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
                    SelectPaymentView(paymentSelected: $paymentSelected)
                        .frame(height: 150)
                    
                  //  ApplePayButtonView(action: CartManager.sharedCart.pay)
                   //Shipping Section
                   // ShippingButtonView(adress: $adrees, postalCode: $postalCode, state: $state)
                   //     .frame(height: 200)
                    
                        
                  //Place order
                    PlaceOrderView(productsInOrder: $productsInCar, userId: $userLoggedIn.id, paymentSelected: $paymentSelected, shippmentAdress: $shipment)
                        
                    
                            
                        
                    }
                    //List
              }
               //if else
               
            }
           //Vstack
            .onAppear{
                if CartManager.sharedCart.paymentSucces {
                   CartManager.sharedCart.paymentSucces = false
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
