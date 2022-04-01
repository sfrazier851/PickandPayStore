//
//  ContentView.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import SwiftUI

struct ContentView: View {
    
    // Instance of CartManager so you can access its functions.
    // Added in this file to ProductCart and CartView.
    @StateObject var cartManager = CartManager()
    
    // Need this variables for the lazy view grid.
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        
        // Here you iterate over the Product list.
        // Need to add HStack so it won't create a new view controler for each product.
        
        NavigationView {
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20){
                    ForEach(productList, id: \.id)  { product in
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                    }
                }
                .padding()
            }
            .navigationTitle(Text("Toy Shop"))
            .toolbar{
                //Navigate to the CartView
                NavigationLink {
                    // This is the destination.
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    //On CartButton click go to CartView.
                    CartButton(numberOfProducts: cartManager.products.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
