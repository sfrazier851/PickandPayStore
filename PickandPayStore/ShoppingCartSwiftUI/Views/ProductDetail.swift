//
//  SwiftUIView.swift
//  PickandPayStore
//
//  Created by admin on 4/3/22.
//

import SwiftUI

struct ProductDetailView: View {

    
    @State var total : Int = 1
    @State var inWishlist: Bool = false
    
    @Binding var numberInCart : Int
    @Binding var products: [Product]
   
    var product : Product
    var body: some View {
      // ScrollView{
       
        
        
        VStack{
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
                                //available only in IOS 15 .background(.black)
                                .cornerRadius(20)
                                .frame(width: 30, height: 30)
                                
                        }
                        .background(Color.gray)
                        .cornerRadius(5)
                    Spacer()
            }.padding(.leading, 160)
                    
                Button{
                    CartManager.sharedCart.addToCart(product: product, count: total)
                    numberInCart += total
                    products = CartManager.sharedCart.products
                }label: {
                    Text("Add To Cart")
                        .frame(width: 320, height: 20, alignment: .center)
                        .foregroundColor(.black)
                }
                .background(Color.gray)
                .cornerRadius(5)
            
                Button{
                    
                    if inWishlist {
                        WishlistManager.sharedWishlist.removeFromWishlist(productName: product.name)
                    }
                    else{
                        WishlistManager.sharedWishlist.addToWishlist(productName: product.name)
                    }
                    inWishlist.toggle()
                    print(inWishlist)
                    print(WishlistManager.sharedWishlist.getWishlist())
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
        
        
                
                
                List{
                    Section{
                    let p = ProductReview.getByProductID(productID: product.id)
                            ForEach(p! , id: \.id){ productreview in
                                Text(productreview.review)
                                }
                        
                        if p?.count == 0{
                            Text("No Reviews Yet")
                       }
                    }header:{
                        Text("Reviews")
                    }
                    
                }.frame(width: 320.0).border(Color.black)
               Button{
                   
               }label: {
                   Text("Add A Review")
                       .frame(width: 320, height: 20, alignment: .center)
                       .foregroundColor(.black)
               }
               .background(Color.gray)
               .cornerRadius(5)
            
             Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .onAppear(){
                inWishlist = WishlistManager.sharedWishlist.getWishlist().contains(product.name)
            }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(inWishlist: true, numberInCart: .constant(1), products: .constant([]), product: Product(categoryID: 3, name: "buddy", price: 9000, imageName: "buddy"))
            
    }
}

