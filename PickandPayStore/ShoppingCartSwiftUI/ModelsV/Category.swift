//
//  Category.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/4/22.
//

import Foundation

struct Category: Identifiable{
    
    var id = UUID()
    var name: String
    var image: String
}

// Dummy data. Created so it can be used for display.
// The Product objects are initialized without the id property cuz the id is already set up in the model.

//var productList = [Category(name: "", image: "bear", price: 9.99),
                   //Product(name: "Circles", image: "circles", price: 16.98),
                   //Product(name: "Dino", image: "dino", price: 29.97),
                   //Product(name: "Unicorn", image: "unicorn", price: 3.99),]
