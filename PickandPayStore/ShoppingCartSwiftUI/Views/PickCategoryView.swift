//
//  PickCategoryView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/5/22.
//

import SwiftUI

struct PickCategoryView: View {
    
    @StateObject var productsManager: ProductsManager = ProductsManager()
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                    Text("Pick a Category").bold()
                    VStack{
                        //Text("Pick a Category")
                        ForEach(productsManager.categories, id: \.id){ category in
                            NavigationLink(destination: CategoryContentView(category: category, productsList: productsManager.getProductsOfCategory(category: category.id))
                                    .environmentObject(productsManager))
                                {
                                    CategoryCard(category: category)
                                        .environmentObject(productsManager)
                            }
                    }
                    .padding()
                }
                .toolbar(content:{
                    ToolbarItem(placement: .principal, content: {
                            Text("Millennium Technologies")
                            .font(.title).fontWeight(.bold)
                        })
                })
        }
    }
    
}
}

struct PickCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        PickCategoryView()
    }
}

