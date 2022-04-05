//
//  Category.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct CategoryM {
    var id: Int = 0
    var departmentID: Int = 0
    var name: String = ""
    var imageName: String = ""
    
    static let category = CategoryM()
    
    // Convert query result set to Array of Category
    static func convert(categoriesResultSet: [[String]]) -> [CategoryM]? {
        var categories = [CategoryM]()
        for category_row in categoriesResultSet {
            let columns = category_row
            
            var category = CategoryM()
            category.id = Int(columns[0])!
            category.departmentID = Int(columns[1])!
            category.name = columns[2]
            category.imageName = columns[3]
            
            categories.append(category)
        }
        return categories
    }
    
    static func getAll() -> [CategoryM]? {
        return SQLiteDAL.getAllCategories()
    }
    
    static func getByName(name: String) -> [CategoryM]? {
        return SQLiteDAL.getCategoriesByName(name: name)
    }
    
    static func create(departmentID: Int, name: String, imageName: String) -> Bool? {
        return SQLiteDAL.createCategory(departmentID: departmentID, name: name, imageName: imageName)
    }
}
