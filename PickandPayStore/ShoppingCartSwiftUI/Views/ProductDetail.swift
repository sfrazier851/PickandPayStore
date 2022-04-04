//
//  SwiftUIView.swift
//  PickandPayStore
//
//  Created by admin on 4/3/22.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartManager: CartManager
    @State var total : Int = 1
    var product : Product
    var body: some View {
       // ZStack{
        VStack(alignment: .leading){
                HStack(alignment: .top){
                    Image(product.image)
                        .resizable()
                        .frame(width: 300, height: 300)
                    VStack(alignment: .leading){
                        Text(product.name)
                            .font(.largeTitle)
                        Text("$\(product.price, specifier: "%.2f")")
                    }
                }
                HStack{
                    Button {
                        if cartManager.total != 0{
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
                .padding(.leading, 100.0)
            Button{
                cartManager.addToCart(product: product, count: total)
            }label: {
                Text("Add To Cart")
                    .frame(width: 300, height: 20, alignment: .center)
                    .foregroundColor(.black)
            }
            .background(Color.gray)
            .cornerRadius(5)
                    Spacer()
            }
        
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productList[0])
            .environmentObject(CartManager())
    }
}
