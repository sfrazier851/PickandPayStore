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
    var category: String
    var image: String
    var price: Double
}

// Dummy data. Created so it can be used for display.
// The Product objects are initialized without the id property cuz the id is already set up in the model.

/*var productList = [Product(name: "Bear", image: "bear", price: 9.99),
                   Product(name: "Circles", image: "circles", price: 16.98),
                   Product(name: "Dino", image: "dino", price: 29.97),
                   Product(name: "Unicorn", image: "unicorn", price: 3.99),]*/

/*var productList  = [ Product(name: "bb8", category: "droids", image: "bb8", price: 19000),
                    Product(name: "buddy", category: "droids", image: "buddy", price: 9000),
                    Product(name: "c3po", category: "droids", image: "c3po", price: 8000),
                    Product(name: "death star droid", category: "droids", image: "death-star-droid", price: 29000),
                    Product(name: "destroyer", category: "droids", image: "destroyer", price: 19400),
                    Product(name: "k2so", category: "droids", image: "k2so", price: 3400),
                    Product(name: "r5d4", category: "droids", image: "r5d4", price: 1876),
                     
                    Product(name: "falcon", category: "spaceships", image: "falcon", price: 190008),
                    Product(name: "ghost", category: "spaceships", image: "ghost", price: 95000),
                    Product(name: "sa-bomber", category: "spaceships", image: "sa-bomber", price: 86500),
                    Product(name: "striker", category: "spaceships", image: "striker", price: 299000),
                    Product(name: "star destroyer", category: "spaceships", image: "star-destroyer", price: 179400),
                    Product(name: "x wing", category: "spaceships", image: "x-wing", price: 123400),
                    Product(name: "y wing", category: "spaceships", image: "y-wing", price: 111876),
                     
                    
                    Product(name: "at ap", category: "ground", image: "at-ap", price: 54005),
                    Product(name: "at at", category: "ground", image: "at-at", price: 35000),
                    Product(name: "at st", category: "ground", image: "at-st", price: 86500),
                    Product(name: "at sw", category: "ground", image: "at-sw", price: 99000),
                    Product(name: "at te", category: "ground", image: "at-te", price: 179409),
                    Product(name: "speeder", category: "ground", image: "speeder", price: 23345),
                    Product(name: "tank", category: "ground", image: "tank", price: 111110)
]
*/
