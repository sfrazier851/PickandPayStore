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

/*var categoryList = [Category(name: "spaceships", image: "x-wing"),
                    Category(name: "ground", image: "speeder" ),
                    Category(name: "droids", image: "buddy" )]*/
