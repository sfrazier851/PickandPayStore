//
//  SwiftUIView.swift
//  PickandPayStore
//
//  Created by admin on 4/3/22.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.defaultMinListRowHeight) var minRowheight
    @EnvironmentObject var cartManager: CartManager
    @State var total : Int = 1
    var product : ProductM
    var body: some View {
      // ScrollView{
       
           VStack(alignment: .leading){
              // Text(product.name)
                   //.font(.largeTitle)
                    HStack(alignment: .top){
                        Image(product.imageName)
                            .resizable()
                            .frame(width: 280, height: 280)
                        VStack(alignment: .leading){
                            
                            Text("$\(product.price, specifier: "%.2f")")
                           
                        }
                        
                    }
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
                    }
                    .padding(.leading, 90.0)
                Button{
                    cartManager.addToCart(product: product, count: total)
                }label: {
                    Text("Add To Cart")
                        .frame(width: 280, height: 20, alignment: .center)
                        .foregroundColor(.black)
                }
                .background(Color.gray)
                .cornerRadius(5)
                Button{
                    
                }label: {
                    Text("Add To Wishlist")
                        .frame(width: 280, height: 20, alignment: .center)
                        .foregroundColor(.black)
                }
                .background(Color.gray)
                .cornerRadius(5)
                //Text("Reviews")
                   // .font(.largeTitle)
                    //.padding(.leading, 80)
                    
                List{
                    Section{
                    let p = SQLiteDAL.getReviewsByProductID(productID: product.id)
                            ForEach(p!, id: \.id){ productreview in
                                Text(productreview.review)
                                }
                        
                        if p?.count == 0{
                            Text("No Reviews Yet")
                       }
                    }header:{
                        Text("Reviews")
                    }
                    
                }.frame(width: 280.0).border(Color.black)
                
            }
           .navigationTitle(Text(product.name))
      // }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: ProductM(categoryID: 3, name: "buddy", price: 9000, imageName: "buddy"))
            .environmentObject(CartManager())
    }
}
