//
//  CartManager.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import Foundation
import SwiftUI

class CartManager: ObservableObject {
    
    // Add the private(set) to variables, so they can be set only within this class.
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Float = 0
    private(set) var productsToBeRemoved: [Product] = []
    
   // Add to cart.
    func addToCart(product: Product, count: Int){
        for _ in 1...count{
            products.append(product)
            total += product.price
        }
        //total += product.price
    }
    
    // Remove from cart.
    func removeFromCart(product: Product){

        // Isolate the product that need to be removed. The cart could contain more than one product of the same type.
        productsToBeRemoved = products.filter{ $0.id == product.id}
        // Remove all the products that are the same as the product that needs to be removed.
        products = products.filter{$0.id != product.id}
        
        // Check if productsToBeremoved has any elements. And substract the price of the product.
        if(productsToBeRemoved.count > 0)
        {
            total -= productsToBeRemoved[0].price
            productsToBeRemoved.remove(at: 0)
        }
        // Append what is left to the productsToBeRemoved to the products array.
        products = products + productsToBeRemoved
        
    }
    
    func printManager(){
        
        for p in products{
            print(p.name)
        }
        
        print(self.total)
    }
}
