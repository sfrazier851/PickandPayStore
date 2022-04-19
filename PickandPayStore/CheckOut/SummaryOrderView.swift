//
//  SummaryOrderView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct SummaryOrderView: View {
    @State var productsInCar = [
        Product(id: 1, categoryID: 1, name: "Ghost", price: 95000, imageName: "ghost", description: "destroy everybody"),
        Product(id: 2, categoryID: 1, name: "SA-Bomber", price: 86500, imageName: "sa-bomber", description: "a bomber"),
        Product(id: 3, categoryID: 1, name: "Striker", price: 299000, imageName: "striker", description: "a striker"),
        Product(id: 4, categoryID: 1, name: "Star destroyer", price: 179400, imageName: "star-destroyer", description: " a star destroyer")]
    //@State var userLoggedIn: User
    
    
    @State var subtotal: Float = 0
    var body: some View {
        VStack{
            
                ForEach(productsInCar,id: \.id){product in
                    HStack{
                        Text("\(product.name)")
                        Spacer()
                        Text(" $\(product.price,specifier: "%.2f")")
                        
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
                    
                Spacer()
                Text("$ \(getTotal(products:productsInCar),specifier: "%.2f")")
                
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

struct SummaryOrderView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryOrderView()
    }
}
