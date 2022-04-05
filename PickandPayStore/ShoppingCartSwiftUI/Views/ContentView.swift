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
    //@State private var showingProductDetail = false
    //@Binding var showingProductDetail: Bool
    
    
    // Need this variables for the lazy view grid.
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        
        
        // Here you iterate over the Product list.
        // Need to add HStack so it won't create a new view controler for each product.
        
        NavigationView {
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20){
                    ForEach(productList, id: \.id)  { product in
                        NavigationLink(destination: ProductDetailView(product: product)
                                        .environmentObject(cartManager))
                        {
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                            
                        }
                            
                    }
                }
                .padding()
            }
            .navigationTitle(Text("Toy Shop"))
            .toolbar{
                /* Commented out due to build errors
                //Navigate to the CartView
                //  Build error messages(2):
                // Type '() -> CartButton' cannot conform to 'View'; only struct/enum/class types can conform to protocols
                // Type '() -> some View' cannot conform to 'StringProtocol'; only struct/enum/class types can conform to protocols
                NavigationLink {
                    // This is the destination.
                    CartView()
                        .environmentObject(cartManager)
                } destination: {
                    //On CartButton click go to CartView.
                    CartButton(numberOfProducts: cartManager.products.count)
                }
                */
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct mainView: View{
//
//    @State var showingProductDetail = false
//    @State var productSelection : Product?
//
//    var body: some View {
//        Group {
//            if !showingProductDetail{
//                ContentView()
//            }
//            else{
//                ProductDetailView(product: productSelection!)
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
