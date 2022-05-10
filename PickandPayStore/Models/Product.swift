//
//  Product.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

// Product Model is for all Database operations for the entity.
// NOTE: the order of public properties matters and MUST match the order of columns
//   in the database table definition.
struct Product: Equatable {
    var id: Int = 0
    var categoryID: Int = 0
    var name: String = ""
    var price: Float = 0.0
    var imageName: String = ""
    var description: String = ""
    
    // pass in the database for the application
    private static var productDAL: ProductDAL? = ProductDAL(db: SQLiteDatabase.getDatabase(), convert: convert)
    
    // set the database to be an in-memory database for tests
    static func setTestingTrue() {
        productDAL = ProductDAL(db: SQLiteDatabase.getInMemoryTestDatabase(), convert: convert)
    }
    
    // Convert query result set to Array of Product
    static func convert(productsResultSet: [[String]]) -> [Product]? {
        var products = [Product]()
        for product_row in productsResultSet {
            let columns = product_row
            
            var product = Product()
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
    
    static func getAll() -> [Product]? {
        guard let productDAL = productDAL else {
            return nil
        }
        return productDAL.getAllProducts()
    }
    
    static func getByID(productID: Int) -> [Product]? {
        guard let productDAL = productDAL else {
            return nil
        }
        return productDAL.getProductByID(productID: productID)
    }
    
    static func getByName(name: String) -> [Product]? {
        guard let productDAL = productDAL else {
            return nil
        }
        return productDAL.getProductsByName(name: name)
    }
    
    static func create(categoryID: Int, name: String, price: Float, imageName: String, description: String) -> Product? {
        guard let productDAL = productDAL else {
            return nil
        }
        return productDAL.createProduct(categoryID: categoryID, name: name, price: price, imageName: imageName, description: description)
    }
}
