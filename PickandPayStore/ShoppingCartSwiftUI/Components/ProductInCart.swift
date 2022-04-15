//
//  ProductInCart.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import SwiftUI

struct ProductInCart: View {
    // Environment object modifier of CartManager, and ProductsManager type.
    @EnvironmentObject var productsManager: ProductsManager
    @Binding var productsInCart : [Product]
    @Binding var numberInCart: Int
    var product: Product
    
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
                    CartManager.sharedCart.removeFromCart(product: product)
                    productsInCart = CartManager.sharedCart.products
                    numberInCart -= 1
                    CartManager.sharedCart.printManager()
                }
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

//struct ProductInCart_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        ProductInCart(product: Product(categoryID: 3, name: "bb8", price: 19000, imageName: "bb8"))
//            .environmentObject(ProductsManager())
//    }
//    
//}
