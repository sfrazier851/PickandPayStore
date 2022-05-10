//
//  CategoryDAL.swift
//  PickandPayStore
//
//  Created by iMac on 4/14/22.
//

import Foundation
import SQLite3

class CategoryDAL: SQLiteDAL {
        
    private let category = Category()
    private let db: OpaquePointer?
    // function defined in corresponding model struct
    private let convert: (_ categoryResultSet: [[String]]) -> [Category]?
    
    init(db: OpaquePointer?, convert: @escaping (_ categoryResultSet: [[String]]) -> [Category]?) {
        self.convert = convert
        self.db = db
        super.init(db: db)
    }
    
    // Category DAL (getAllCategories, getCategoriesByName, createCategory)
    func getAllCategories() -> [Category]? {
        guard let categoriesResultSet = CategoryDAL.protectedQuery(modelType: category, queryString: "SELECT * FROM Category;") else {
            return nil
        }
        return self.convert(categoriesResultSet)
    }
    
    func getCategoryByID(categoryID: Int) -> [Category]? {
        guard let categoriesResultSet = CategoryDAL.protectedQuery(modelType: category, queryString: "SELECT * FROM Category WHERE ID = '\(categoryID)';") else {
            return nil
        }
        return self.convert(categoriesResultSet)
    }
    
    func getCategoriesByName(name: String) -> [Category]? {
        guard let categoriesResultSet = CategoryDAL.protectedQuery(modelType: category, queryString: "SELECT * FROM Category WHERE name = '\(name)';") else {
            return nil
        }
        return self.convert(categoriesResultSet)
    }
    
    func createCategory(name: String, imageName: String) -> Category? {
        guard let db = self.db else {
            return nil
        }
        let insertStatementString = "INSERT INTO Category ( name, imageName ) VALUES ( ?, ? )"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, NSString(string: name).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, NSString(string: imageName).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
        
        let newCategoryID = CategoryDAL.protectedGetLatestInsertId()!
        return Category.getByID(categoryID: newCategoryID)![0]
    }
    
}
