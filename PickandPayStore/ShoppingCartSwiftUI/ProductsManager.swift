//
//  ProductsManager.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/5/22.
//

import Foundation
import SwiftUI


class ProductsManager: ObservableObject{
    
    @Published var productList = [ProductM]()
    @Published var categories = [CategoryM]()
    
    // The init fills the entire products array. This is done for UI testing purposes only.
    // When the UI gets connected to the database the majority of the functions in this class will be re-written.
    // All the queries to the database that are related to the products should be written in this class.
    init(){
        if let p = SQLiteDAL.getAllProducts(){
            for product in p{
                productList.append(product)
            }
        }
        if let c = SQLiteDAL.getAllCategories(){
            for category in c{
                categories.append(category)
            }
        }
    }
    
    
    // Fill the product list.
//    func fillProductsList(){
//
//        // Add elements to the productLists.
//        productList.append(Product(name: "bb8", category: "droids", image: "bb8", price: 19000))
//        productList.append(Product(name: "buddy", category: "droids", image: "buddy", price: 9000))
//        productList.append(Product(name: "c3po", category: "droids", image: "c3po", price: 8000))
//        productList.append(Product(name: "death star droid", category: "droids", image: "death-star-droid", price: 29000))
//        productList.append(Product(name: "destroyer", category: "droids", image: "destroyer", price: 19400))
//        productList.append(Product(name: "k2so", category: "droids", image: "k2so", price: 3400))
//        productList.append(Product(name: "r5d4", category: "droids", image: "r5d4", price: 1876))
//
//        productList.append(Product(name: "falcon", category: "spaceships", image: "falcon", price: 190008))
//        productList.append(Product(name: "ghost", category: "spaceships", image: "ghost", price: 95000))
//        productList.append(Product(name: "sa-bomber", category: "spaceships", image: "sa-bomber", price: 86500))
//        productList.append(Product(name: "striker", category: "spaceships", image: "striker", price: 299000))
//        productList.append(Product(name: "star destroyer", category: "spaceships", image: "star-destroyer", price: 179400))
//        productList.append(Product(name: "x wing", category: "spaceships", image: "x-wing", price: 123400))
//        productList.append(Product(name: "y wing", category: "spaceships", image: "y-wing", price: 111876))
//
//
//        productList.append(Product(name: "at ap", category: "ground", image: "at-ap", price: 54005))
//        productList.append(Product(name: "at at", category: "ground", image: "at-at", price: 35000))
//        productList.append(Product(name: "at st", category: "ground", image: "at-st", price: 86500))
//        productList.append(Product(name: "at sw", category: "ground", image: "at-sw", price: 99000))
//        productList.append(Product(name: "at te", category: "ground", image: "at-te", price: 179409))
//        productList.append(Product(name: "speeder", category: "ground", image: "speeder", price: 23345))
//        productList.append(Product(name: "tank", category: "ground", image: "tank", price: 111110))
//    }
    
    // Add elements to the categories list. If there is no categories table in the database, this list will remain hardcoded.
//    func fillCategoriesList(){
//        categories.append(Category(name: "spaceships", image: "x-wing"))
//        categories.append(Category(name: "ground", image: "speeder" ))
//        categories.append(Category(name: "droids", image: "buddy" ))
//
//    }
    
    
    // Get products by category name.
    func getProductsOfCategory(category: Int) -> [ProductM]{
        let productsOfCategory = productList.filter{$0.categoryID == category}
        return productsOfCategory
    }
    
    // Get the products list.
    func getProductsList() -> [ProductM]{
        return self.productList
    }
    
    // Get The categories list.
    func getCategoriesList() -> [CategoryM]{
        return self.categories
    }
}
