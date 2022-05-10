//
//  Category.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

// Category Model is for all Database operations for the Category entity.
// NOTE: the order of public properties matters and MUST match the order of columns
//   in the database table definition.
struct Category: Equatable{
    var id: Int = 0
    var name: String = ""
    var imageName: String = ""
    
    // pass in the database for the application
    private static var categoryDAL: CategoryDAL? = CategoryDAL(db: SQLiteDatabase.getDatabase(), convert: convert)
    
    // set the database to be an in-memory database for tests
    static func setTestingTrue() {
        categoryDAL = CategoryDAL(db: SQLiteDatabase.getInMemoryTestDatabase(), convert: convert)
    }
    
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
    
    // Category queries and creation
    static func getAll() -> [Category]? {
        guard let categoryDAL = categoryDAL else {
            return nil
        }
        return categoryDAL.getAllCategories()
    }
    
    static func getByID(categoryID: Int) -> [Category]? {
        guard let categoryDAL = categoryDAL else {
            return nil
        }
        return categoryDAL.getCategoryByID(categoryID: categoryID)
    }
    
    static func getByName(name: String) -> [Category]? {
        guard let categoryDAL = categoryDAL else {
            return nil
        }
        return categoryDAL.getCategoriesByName(name: name)
    }
    
    static func create(name: String, imageName: String) -> Category? {
        guard let categoryDAL = categoryDAL else {
            return nil
        }
        return categoryDAL.createCategory(name: name, imageName: imageName)
    }
}
