//
//  Product.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct ProductM {
    var id: Int = 0
    var categoryID: Int = 0
    var name: String = ""
    var price: Float = 0.0
    var imageName: String = ""
    var description: String = ""
    
    static let productDAL = { () -> ProductDAL? in
        if let db = SQLiteDatabase.getDatabase() {
            return ProductDAL(db: db, convert: convert)
        }
        return nil
    }()
    // Convert query result set to Array of Product
    static func convert(productsResultSet: [[String]]) -> [ProductM]? {
        var products = [ProductM]()
        for product_row in productsResultSet {
            let columns = product_row
            
            var product = ProductM()
            product.id = Int(columns[0])!
            product.categoryID = Int(columns[1])!
            product.name = columns[2]
            product.price = Float(columns[3])!
            product.imageName = columns[4]
            product.description = columns[5]
            
            products.append(product)
        }
        return products
    }
    
    static func getAll() -> [ProductM]? {
        guard let productDAL = productDAL else {
            return nil
        }
        return productDAL.getAllProducts()
    }
    
    static func getByID(productID: Int) -> [ProductM]? {
        guard let productDAL = productDAL else {
            return nil
        }
        return productDAL.getProductByID(productID: productID)
    }
    
    static func getByName(name: String) -> [ProductM]? {
        guard let productDAL = productDAL else {
            return nil
        }
        return productDAL.getProductsByName(name: name)
    }
    
    static func create(categoryID: Int, name: String, price: Float, imageName: String, description: String) -> Bool? {
        guard let productDAL = productDAL else {
            return nil
        }
        return productDAL.createProduct(categoryID: categoryID, name: name, price: price, imageName: imageName, description: description)
    }
}
