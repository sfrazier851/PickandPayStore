//
//  PickCategoryView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/5/22.
//

import SwiftUI
import MapKit

struct PickCategoryView: View {
    
    @State var searchText = ""
    @State var searching = false
    @State var pastSearches = [String]()
    
    @StateObject var productsManager: ProductsManager = ProductsManager()
    
    var body: some View {
        
        NavigationView {
            ZStack{
                
                ScrollView{
                
                    //Text("Pick a Category").bold()
                    VStack{
                        SearchBar(searchText: $searchText, searching: $searching, pastSearches: $pastSearches)

//                        if searching{
//                            List{
//                               // Section{
//                                Text("Words")
//                                ForEach(pastSearches, id: \.self){ text in
//                                    Text(text)
//
//                                }
//                                }
//                            //}.frame(width: 280.0).border(Color.black)
//                        }
                        //Text("Pick a Category")
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
                
//                if searching{
//                    List{
//                        
//                        ForEach(pastSearches, id: \.self){ text in
//                            Text(text).onTapGesture{
//                                searchText = text
//                                
//                            }
//
//                        }
//                    }.frame(height: 100*CGFloat(pastSearches.count)).padding(.top, 0)
//                }
                
            }
    }
        
}
}

struct PickCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        PickCategoryView()
    }
}

