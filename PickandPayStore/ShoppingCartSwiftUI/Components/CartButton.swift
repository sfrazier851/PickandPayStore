//
//  CartButton.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import SwiftUI

struct CartButton: View {
    
    // This variable holds the number of products in the cart.
    var numberOfProducts: Int
    
    var body: some View {
        
        ZStack(alignment: .topTrailing){
            Image(systemName: "cart")
                .padding(.top, 15)
                .foregroundColor(.red)
            
            // Check if the cart has one or more items in it.
            if(numberOfProducts > 0)
            {
                Text("\(numberOfProducts)")
                    .font(.caption2).bold()
                    .foregroundColor(.black)
                    .frame(width: 25, height: 25)
            }
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        // Pass the numberOfProducts variable here.
        CartButton(numberOfProducts: 1)
    }
}
