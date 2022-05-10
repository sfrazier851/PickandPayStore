//
//  SQLiteDAL.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation
import SQLite3

// Base class for the Data Access Layer

class SQLiteDAL {
    
    private static var db: OpaquePointer?
    
    init(db: OpaquePointer?) {
        SQLiteDAL.db = db
    }
    
    // return array of types, for struct properties
    // in order of declaration
    internal static func getColumnTypes(modelType: Any) -> [String] {
        let mirror = Mirror(reflecting: modelType)
        var columnTypes = [String]()
        
        for prop in mirror.children {
            columnTypes.append(String(describing: type(of: prop.value)))
        }
        return columnTypes
    }
    
    // Return latest row id.
    // For getting id of most recently
    // created db entity.
    static func protectedGetLatestInsertId() -> Int? {
        guard let db = db else {
            return nil
        }
        let lastRowId = sqlite3_last_insert_rowid(db)
        return Int(lastRowId)
    }
    
    // general purpose query (NOTE: QUERY MUST RETURN ALL FIELDS OF TABLE!)
    static func protectedQuery(modelType: Any, queryString: String) -> [[String]]? {
        guard let db = db else {
            return nil
        }
        
        let columnTypes = getColumnTypes(modelType: modelType)
        
        // initialize the result set array of arrays ( rows : [ columns [] ]  )
        var rowsArr = [[String]]()
        var columnsArr = [String]()
        
        var stmt: OpaquePointer?
        
        //prepare query
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("error running query: \(error)")
            exit(1)
        }
        
        // iterate through result set rows
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            var i = 0
            // iterate through columns
            while i < columnTypes.count {
                var column: String
                
                switch columnTypes[i] {
                    case "Float":
                        column = String(sqlite3_column_double(stmt, Int32(i)))
                    case "Int":
                        column = String(sqlite3_column_int(stmt, Int32(i)))
                    case "Bool":
                        column = String(sqlite3_column_int(stmt, Int32(i)))
                    default: //String
                        column = String(cString: sqlite3_column_text(stmt, Int32(i)))
                }
                columnsArr.append(column)
                i += 1
            }
            rowsArr.append(columnsArr)
            // clear columns array for next row
            columnsArr.removeAll()
        }
        // delete compiled statment to avoid resource leaks
        sqlite3_finalize(stmt)
        return rowsArr
    }
}
