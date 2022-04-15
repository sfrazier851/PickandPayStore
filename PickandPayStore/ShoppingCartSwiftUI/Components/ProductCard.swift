//
//  ProductCard.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import SwiftUI

struct ProductCard: View {
    
    // Environment object modifier of CartManager type.
    @EnvironmentObject var productsManager: ProductsManager
    
    // It displays a Product object.
    var product: Product
    @Binding var numberInCart : Int
    @Binding var products: [Product]
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            VStack{
                Image(product.imageName)
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: 180)
                    .scaledToFit()
                
                // This VStack contains the name and price of the toy.
                HStack {
                    VStack(alignment: .leading){
                            Text(product.name)
                                .bold()
                            
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.caption)
                        }
                        .padding()
                        .frame(width: 150, alignment: .leading)
                    // Only for IOS 15 and above.
                    //.background(.ultraThinMaterial)
                    .cornerRadius(20)
                    Button {
                        CartManager.sharedCart.addToCart(product: product, count: 1)
                        numberInCart += 1
                        products = CartManager.sharedCart.products
                        
                        CartManager.sharedCart.printManager()
                     } label: {
                         Image(systemName: "plus")
                             .padding(5)
                             .foregroundColor(.black)
                             //available only in IOS 15 .background(.black)
                             .cornerRadius(50)
                             //.padding()
                     }
                    
                }
            }
            
        }
        .frame(width: 200, height: 250)
        .shadow(radius: 3)
    }
}


//struct ProductCard_Previews: PreviewProvider {
//    static var previews: some View {
//        // You pass the argument that needs to be displayed here.
//        ProductCard(product: Product(categoryID: 3, name: "bb8", price: 19000, imageName: "bb8"), numberInCart: <#Binding<Int>#>)
//    }
//}
