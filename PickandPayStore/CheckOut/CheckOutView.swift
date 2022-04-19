//
//  CheckOutView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct CheckOutView: View {
  
    
    
    @State var productsInCar: [Product] = []
    //@State var userLoggedIn: User
    
    
    @State var subtotal: Float = 0
    
    /*let order = PurchaseOrder.create(userID: <#T##Int#>, paymentType: <#T##String#>, shippingAddress: <#T##String#>)
    
    func fillproducts(){
    
    }*/
    
    var body: some View {
        NavigationView{
            
            VStack{
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
                
                SelectPaymentView()
                    .frame(height: 150)
                
              
                
                
               ShippingButtonView()
                    .frame(height: 200)
               PlaceOrderView()
                    
                        .navigationTitle("Order list")
                        .onAppear(){
                            productsInCar = CartManager.sharedCart.products
                           //need to fecht the user logged in
                            
                        }
                    
                }
                //List
                
               
            }
           //Vstack
           
        
        }
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
