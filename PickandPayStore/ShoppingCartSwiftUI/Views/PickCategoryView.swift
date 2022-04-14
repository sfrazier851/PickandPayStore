//
//  PickCategoryView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/5/22.
//

import SwiftUI
import MapKit

struct PickCategoryView: View {
    
    //State variables for searchbar
    @State var searchText = ""
    @State var searching = false
    @State var pastSearches = [String]()
    
    @StateObject var productsManager: ProductsManager = ProductsManager()
    
    var body: some View {
        
        NavigationView {
            ZStack{
                
                ScrollView{
                
                    
                    VStack{
                        //Create search bar at top of Vstack
                        SearchBar(searchText: $searchText, searching: $searching, pastSearches: $pastSearches)

                        ForEach(productsManager.categories.filter({ (category: CategoryM) -> Bool in
                            return category.name.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""
                        }), id: \.id){ category in
                            NavigationLink(destination: CategoryContentView(category: category, productsList: productsManager.getProductsOfCategory(category: category.id))
                                    .environmentObject(productsManager))
                                {
                                    CategoryCard(category: category)
                                        .environmentObject(productsManager)
                            }
                    }
                    .padding()
                }
                    .toolbar{
                        if searching{
                            Button("Cancel Search"){
                                searchText = ""
                                withAnimation{
                                    searching = false
                                    UIApplication.shared.dismissKeyboard()
                                }
                            }
                        }
                    }
                .navigationTitle(Text("Categories"))
                }
                
            }
    }
        
}
}

struct PickCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        PickCategoryView()
    }
}

