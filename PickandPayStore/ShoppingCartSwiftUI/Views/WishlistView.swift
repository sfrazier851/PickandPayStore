//
//  Wishlist.swift
//  PickandPayStore
//
//  Created by admin on 4/11/22.
//

import SwiftUI

struct WishlistView: View {
    
    @Binding var udWishlist: [String:Int]
    var body: some View {
        List{
            ForEach(udWishlist.sorted(by: >), id: \.key){ key, value in
                Text(key)
                Text("\(value)")
                
            }
        }
    }
}

//struct WishlistView_Previews: PreviewProvider {
//    static var previews: some View {
//        WishlistView()
//    }
//}
