//
//  ProductInCart.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import SwiftUI

struct ProductInCart: View {
    // Environment object modifier of CartManager, and ProductsManager type.
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var productsManager: ProductsManager

    var product: ProductM
    
    var body: some View {
        HStack(spacing: 20){
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10){
                Text(product.name)
                    .bold()
                
                Text("$\(product.price, specifier:"%.2f")")
            }
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    cartManager.removeFromCart(product: product)
                    cartManager.printManager()
                }
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

struct ProductInCart_Previews: PreviewProvider {
    
    static var previews: some View {
        ProductInCart(product: ProductM(categoryID: 3, name: "bb8", price: 19000, imageName: "bb8"))
            .environmentObject(CartManager())
            .environmentObject(ProductsManager())
    }
    
}
