//
//  CategoryContentView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/5/22.
//

import SwiftUI
import MapKit

struct CategoryContentView: View {
    
    //State variables for searchbar
    @State var searchText = ""
    @State var searching = false
    @State var pastSearches = [String]()
    
    // State variables for side menu.
    @State var showMenu = false
    
    @Binding var numberInCart: Int
    
    // Instance of CartManager and ProductsManager so you can access its functions and //properties.
    // Added cartManager to ProductCart and CartView.
    @EnvironmentObject var productsManager: ProductsManager    
    
    var category: Category
    var productsList: [Product]
    
    // Need this variables for the lazy view grid.
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        
       //Create SearchBar outside of scrollview so it always shows on top
        
        
        ZStack {
                
            if showMenu {
                SideMenuView(isShowing: $showMenu)
            }
            ZStack{
                
            
            ScrollView {
                SearchBar(searchText: $searchText, searching: $searching, pastSearches: $pastSearches)
                // Here you iterate over the Product list.
                LazyVGrid(columns: columns, spacing: 20){
                    
                    ForEach(productsList.filter({ (product: Product) -> Bool in
                        return product.name.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""
                    }), id: \.id)  { product in
                        
                        //Add a navigation link to each product card
                        NavigationLink(destination: ProductDetailView(product: product))
                        {
                            ProductCard(product: product, numberInCart: $numberInCart)
                        //Filter list based on text in search bar
                        }
                    }
                }
                    .padding()
                
                   
                .navigationTitle(Text(category.name))
                    
                //If using the search bar, add a cancel search button
                .toolbar{
                    ToolbarItem{
                        if searching{
                            Button("Cancel Search"){
                                searchText = ""
                                withAnimation{
                                    searching = false
                                    UIApplication.shared.dismissKeyboard()
                                }
                            }
                        }
                        //Navigate to the CartView
                        NavigationLink {
                            // This is the destination.
                            CartView()
                        } label: {
                            //On CartButton click go to CartView.
                            CartButton(numberInCart: $numberInCart)
                        }
                    }
                    
                    ToolbarItem (placement: .navigationBarLeading){
                        MenuButton(isOpen: $showMenu).onTapGesture {
                            withAnimation(.spring())
                            {
                                showMenu.toggle()
                            }
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .offset(x: showMenu ? 200 : 0, y: 0)
        }
        .onAppear(){
            showMenu = false
            numberInCart = CartManager.sharedCart.products.count
        }
    }
}



//struct CategoryContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryContentView(category:Category(name: "ground", imageName: "speeder" ),
//                            productsList: ProductsManager().getProductsOfCategory(category: 1))
//            .environmentObject(ProductsManager())
//    }
//}

}
