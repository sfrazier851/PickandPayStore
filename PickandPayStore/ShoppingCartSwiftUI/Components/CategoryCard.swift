//
//  CategoryCard.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/5/22.
//

import SwiftUI

struct CategoryCard: View {
    
    @EnvironmentObject var productsManager : ProductsManager
    // A Category variable.
    var category: CategoryM
    
    var body: some View {
      
        ZStack{
            HStack(spacing: 20){
                
                Image(category.imageName)
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    //.cornerRadius(10)
                    .scaledToFit()
                Spacer()
                
                Text(category.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    
                Spacer()
            }
            .padding()
            .border(Color.black, width:2)
            //.frame(maxWidth: .infinity, alignment: .leading)
            
        }
        
    }
            
    
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(category: CategoryM(name: "spaceships", imageName: "y-wing"))
        .environmentObject(ProductsManager())
    }
}
