//
//  ProductInOrderView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/20/22.
//

import SwiftUI

struct ProductInOrderView: View {
    
    var product: [Product]
    
    var body: some View {
        
        HStack(spacing: 20){
            Image(product[0].imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10){
                Text(product[0].name)
                    .bold()
                
                Text("$\(product[0].price, specifier:"%.2f")")
            }
            Spacer()
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/*struct ProductInOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInOrderView(product: Product(categoryID: 3, name: "bb8", price: 19000, imageName: "bb8"))
    }
}*/
