//
//  CheckOutView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct CheckOutView: View {
    
  /*  ( 1, 'Ghost', 95000, 'ghost', ''),
    ( 1, 'SA-Bomber',86500,'sa-bomber', ''),
    ( 1, 'Striker',299000,'striker', ''),
    ( 1, 'Star Destroyer', 179400, 'star-destroyer', ''),*/
    
    
    @State var productsInCar = [
        Product(id: 1, categoryID: 1, name: "Ghost", price: 95000, imageName: "ghost", description: "destroy everybody"),
        Product(id: 2, categoryID: 1, name: "SA-Bomber", price: 86500, imageName: "sa-bomber", description: "a bomber"),
        Product(id: 3, categoryID: 1, name: "Striker", price: 299000, imageName: "striker", description: "a striker"),
        Product(id: 4, categoryID: 1, name: "Star destroyer", price: 179400, imageName: "star-destroyer", description: " a star destroyer")]
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
                
                    
                }
                //List
                
            }
           //Vstack
            .navigationTitle("Order list")
            .onAppear(){
              //  productsInCar = CartManager.sharedCart.products
               // userLoggedIn =
                
            }
        
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
