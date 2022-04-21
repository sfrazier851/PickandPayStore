//
//  SummaryOrderView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct SummaryOrderView: View {
    @State var productsInCar: [Product] = []
    //@State var userLoggedIn: User
    
    
    @State var subtotal: Float = 0
    var body: some View {
        VStack{
            
                ForEach(productsInCar,id: \.id){product in
                    HStack{
                        Text("\(product.name)")
                            .foregroundColor(Color.blue)
                        Spacer()
                        Text(" $\(product.price,specifier: "%.2f")")
                            .foregroundColor(Color.blue)
                    }
                    
                    
                }
            
            
            HStack{
                Text("Sub Total")
                Spacer()
                Text("  $ \(getSubTotal(products:productsInCar),specifier: "%.2f")")
                
            }
           
            HStack{
                Text("Taxes")
                Spacer()
                Text("$ \(calculateTaxes(products:productsInCar),specifier: "%.2f")")
                
            }

            HStack{
                Text("Total")
                    .fontWeight(.heavy)
                Spacer()
                Text("$ \(getTotal(products:productsInCar),specifier: "%.2f")")
                    .fontWeight(.heavy)
            }
        }
        .onAppear(){
            productsInCar = CartManager.sharedCart.products
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

struct SummaryOrderView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryOrderView()
    }
}
