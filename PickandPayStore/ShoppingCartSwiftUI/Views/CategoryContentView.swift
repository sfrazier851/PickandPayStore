//
//  CategoryContentView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/5/22.
//

import SwiftUI

struct CategoryContentView: View {
    
    // Instance of CartManager and ProductsManager so you can access its functions and //properties.
    // Added cartManager to ProductCart and CartView.
    @StateObject var cartManager = CartManager()
    @EnvironmentObject var productsManager: ProductsManager
    
    
    var category: CategoryM
    var productsList: [ProductM]
    
    // Need this variables for the lazy view grid.
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        
        
        // Here you iterate over the Product list.
        // Need to add HStack so it won't create a new view controler for each product.
        
        NavigationView {
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20){
                    ForEach(productsList, id: \.id)  { product in
                        NavigationLink(destination: ProductDetailView(product: product)
                                        .environmentObject(cartManager)
                                        .environmentObject(productsManager))
                        {
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                            
                        }
                            
                    }
                }
                .padding()
            }
            .navigationTitle(Text(category.name))
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



struct CategoryContentView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryContentView(category:CategoryM(name: "ground", imageName: "speeder" ),
        productsList: [])
            .environmentObject(ProductsManager())
    }
}

