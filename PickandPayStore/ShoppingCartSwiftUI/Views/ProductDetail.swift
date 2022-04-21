//
//  SwiftUIView.swift
//  PickandPayStore
//
//  Created by admin on 4/3/22.
//

import SwiftUI

//View for product details
struct ProductDetailView: View {

    //State variables to change view
    @State var total : Int = 1
    @State var inWishlist: Bool = false
    @State var showReview: Bool = false
    @State var p = [ProductReview]()
    
    var product : Product
    var body: some View {
      
        VStack{
            //Product name and price and image at top of vertical stack
            Text(product.name)
                .font(.largeTitle.bold())
                .frame(width: 320, alignment: .leading)
            Text("$\(product.price, specifier: "%.2f")")
                .frame(width: 320, alignment: .leading)
            
            Image(product.imageName)
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 320)
                            .scaledToFit()
                
            //Horizontal stack for plus/minus buttons and total to add to cart
            HStack{
                Button {
                    if total != 1{
                        total -= 1
                    }
                    } label: {
                        Image(systemName: "minus")
                            .foregroundColor(.black)
                                //available only in IOS 15 .background(.black)
                            .frame(width: 30, height: 30)
                    }
                    .background(Color.gray)
                    .cornerRadius(5)
                
                    Text("\(total)")
                        .frame(width: 30 , height: 30, alignment: .center)
                        .border(Color.black, width: 1)
                            //.cornerRadius(5)
                
                    Button {
                        total += 1
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .cornerRadius(20)
                            .frame(width: 30, height: 30)
                    }
                    .background(Color.gray)
                    .cornerRadius(5)
                    Spacer()
            }.padding(.leading, 160)
                  
            //Button for adding to the cart, uses total variable for count
                Button{
                    CartManager.sharedCart.addToCart(product: product, count: total)
                    
                }label: {
                    Text("Add To Cart")
                        .frame(width: 320, height: 20, alignment: .center)
                        .foregroundColor(.black)
                }
                .background(Color.gray)
                .cornerRadius(5)
            
            //Button that determines whether item is in wishlist already or not to display add or remove
                Button{
                    
                    if inWishlist {
                        WishlistManager.sharedWishlist.removeFromWishlist(productName: product.name)
                    }
                    else{
                        WishlistManager.sharedWishlist.addToWishlist(productName: product.name)
                    }
                    inWishlist.toggle()
                }
                label: {
                    
                    if inWishlist {
                        Text("Remove From Wishlist")
                            .frame(width: 320, height: 20, alignment: .center)
                            .foregroundColor(.black)
                    }
                    else{
                        Text("Add To Wishlist")
                            .frame(width: 320, height: 20, alignment: .center)
                            .foregroundColor(.black)
                    }
                }.background(Color.gray).cornerRadius(5)
        
        
                
                //List for reviews of the product
                List{
                    //If reviews exist, display them with section header as title
                        if p != []{
                            ForEach(p , id: \.id){ productreview in
                                Section(header: Text(productreview.title)){
                                    Text("\(productreview.review) - \(User.getByID(userID: productreview.userID)![0].username)")
                                }
                                
                            }
                        }
                    //Otherwise just show the text "No Reviews"
                        if p.count == 0{
                            Text("No Reviews Yet")
                       }
                    
                }.frame(width: 320.0).border(Color.black)
            
            //Determine if the user is logged in to decide if showing the review button is appropriate
            if UserSessionManager.shared.isLoggedIn(){
               Button{
                   showReview.toggle()
               }label: {
                   Text("Add A Review")
                       .frame(width: 320, height: 20, alignment: .center)
                       .foregroundColor(.black)
               }
               .background(Color.gray)
               .cornerRadius(5)
                //Sheet to present the add review screen when show review is toggled to true
               .sheet(isPresented: $showReview, onDismiss: nil){
                   AddReviewView(reviews: $p, productID: product.id, showReview: $showReview)
               }
               }
            
             Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        
        //When the view appears, get all product reviews and determine if item is in wishlist or not based on user login status
        //If user is logged in, wishlist is stored in database, otherwise it is stored in userdefaults
            .onAppear(){
                p = ProductReview.getByProductID(productID: product.id) ?? []
                if UserSessionManager.shared.getLoggedInUser() == nil{
                    inWishlist = WishlistManager.sharedWishlist.getWishlist().contains(product.name)
                }
                else{
                    if Wishlist.getByProductID(productID: Product.getByName(name: product.name)![0].id)?.filter({
                        (wishlist: Wishlist) -> Bool in
                        return wishlist.userID == UserSessionManager.shared.getLoggedInUser()!.id
                    }) != []{
                        inWishlist = true
                    }
                }
            }
            
    }
}

//Preview struct for SwiftUI
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(inWishlist: true, product: Product(categoryID: 3, name: "buddy", price: 9000, imageName: "buddy"))
            
    }
}

