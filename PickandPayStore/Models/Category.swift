//
//  Category.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct Category {
    var id: Int = 0
    var name: String = ""
    var imageName: String = ""
        
    static let categoryDAL = { () -> CategoryDAL? in
        if let db = SQLiteDatabase.getDatabase() {
            return CategoryDAL(db: db, convert: convert)
        }
        return nil
    }()
    
    // Convert query result set to Array of Category
    static func convert(categoriesResultSet: [[String]]) -> [Category]? {
        var categories = [Category]()
        for category_row in categoriesResultSet {
            let columns = category_row
            
            var category = Category()
            category.id = Int(columns[0])!
            category.name = columns[1]
            category.imageName = columns[2]
            
            categories.append(category)
        }
        return categories
    }
    
    static func getAll() -> [Category]? {
        guard let categoryDAL = categoryDAL else {
            return nil
        }
        return categoryDAL.getAllCategories()
    }
    
    static func getByName(name: String) -> [Category]? {
        guard let categoryDAL = categoryDAL else {
            return nil
        }
        return categoryDAL.getCategoriesByName(name: name)
    }
    
    static func create(name: String, imageName: String) -> Bool? {
        guard let categoryDAL = categoryDAL else {
            return nil
        }
        return categoryDAL.createCategory(name: name, imageName: imageName)
    }
}
