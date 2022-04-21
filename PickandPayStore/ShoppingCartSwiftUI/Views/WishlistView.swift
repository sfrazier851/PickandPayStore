//
//  Wishlist.swift
//  PickandPayStore
//
//  Created by admin on 4/11/22.
//

import SwiftUI

struct WishlistView: View {
    
    @State var products: [String] = []
    @State var count: Int = 0
    var body: some View {
        ScrollView {
            
            if count > 0
            {
                ForEach(products, id: \.self){
                    product in
                    ProductInWL(product: (Product.getByName(name: product)?[0])!, products: $products, count: $count)

                }
                
                
            }
            else
            {
                Text("Your wishlist is empty")
            }
            
        }
        .navigationTitle(Text("My Wishlist"))
       // .padding(.top)
        .onAppear(){
            if UserSessionManager.shared.getLoggedInUser() == nil{
                count = WishlistManager.sharedWishlist.getCount()
                products = WishlistManager.sharedWishlist.getWishlist()
            }
            else{
                if let productList = Wishlist.getByUserID(userID: UserSessionManager.shared.getLoggedInUser()!.id){
                    count = productList.count
                
                    for p in productList{
                        products.append(Product.getByID(productID: p.productID)?[0].name ?? "")
                    }
                }
                else{
                    count = 0
                    products = []
                }
            }
        }
    }
        
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WishlistView()
        }
    }
}
