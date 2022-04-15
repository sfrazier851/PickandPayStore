//
//  Wishlist.swift
//  PickandPayStore
//
//  Created by admin on 4/11/22.
//

import SwiftUI

struct WishlistView: View {
    
    @EnvironmentObject var wishlistManager: WishlistManager 
    var body: some View {
        ScrollView {
            
            if wishlistManager.getCount() > 0
            {
                ForEach(wishlistManager.udWishlist, id: \.self){
                    product in
                    ProductInWL(product: (SQLiteDAL.getProductsByName(name: product)?[0])!)
                        .environmentObject(wishlistManager)
                }
                
                
            }
            else
            {
                Text("Your wishlist is empty")
            }
            
        }
        .navigationTitle(Text("My Wishlist"))
       // .padding(.top)
    }
}

//struct WishlistView_Previews: PreviewProvider {
//    static var previews: some View {
//        WishlistView()
//    }
//}
