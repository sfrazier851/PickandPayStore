//
//  Product.swift
//  PickandPayStore
//
//  Created by costin popescu on 3/31/22.
//

import Foundation

struct Product: Identifiable{
    
    var id = UUID()
    var name: String
    var image: String
    var price: Double
}

// Dummy data. Created so it can be used for display.
// The Product objects are initialized without the id property cuz the id is already set up in the model.

var productList = [Product(name: "Bear", image: "bear", price: 9.99),
                   Product(name: "Circles", image: "circles", price: 16.98),
                   Product(name: "Dino", image: "dino", price: 29.97),
                   Product(name: "Unicorn", image: "unicorn", price: 3.99),]
