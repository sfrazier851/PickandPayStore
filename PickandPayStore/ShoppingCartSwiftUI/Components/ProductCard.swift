//
//  ProductCard.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import SwiftUI

struct ProductCard: View {
    
    // Environment object modifier of CartManager type.
    @EnvironmentObject var cartManager: CartManager
    
    // It displays a Product object.
    var product: Product
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            VStack{
                Image(product.image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 180)
                    .scaledToFit()
                
                // This VStack contains the name and price of the toy.
                VStack(alignment: .leading){
                    Text(product.name)
                        .bold()
                    
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.caption)
                }
                .padding()
                .frame(width: 180, alignment: .leading)
                // Only for IOS 15 and above.
                //.background(.ultraThinMaterial)
                .cornerRadius(20)
            
            }
            .frame(width: 180, height: 250)
            .shadow(radius: 3)
            
            Button {
                cartManager.addToCart(product: product, count: 1)
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.black)
                    //available only in IOS 15 .background(.black)
                    .cornerRadius(50)
                    .padding()
            }
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        // You pass the argument that needs to be displayed here.
        ProductCard(product: productList[0])
            .environmentObject(CartManager())
    }
}
