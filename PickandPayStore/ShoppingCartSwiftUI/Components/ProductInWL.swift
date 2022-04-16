//
//  ProductInWL.swift
//  PickandPayStore
//
//  Created by admin on 4/12/22.
//

import SwiftUI

struct ProductInWL: View {
    // Environment object modifier of CartManager, and ProductsManager type.
    

    var product: Product
    
    @Binding var products: [String]
    @Binding var count: Int
    
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
                    WishlistManager.sharedWishlist.removeFromWishlist(productName: product.name)
                    products.removeAll{ $0 == product.name }
                    count -= 1
                }
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

struct ProductInWL_Previews: PreviewProvider {
    
    static var previews: some View {
        ProductInWL(product: Product(categoryID: 3, name: "bb8", price: 19000, imageName: "bb8"), products: .constant(["Ghost"]), count: .constant(1))
    }
    
}
