//
//  SQLiteDatabase.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation
import SQLite3

class SQLiteDatabase {
    // application database instance
    private static let sharedInstance = SQLiteDatabase(testing: false)
    private var database: OpaquePointer?
    static func getDatabase() -> OpaquePointer? {
        return sharedInstance.database
    }
    
    // testing database instance
    private static let testInstance = SQLiteDatabase(testing: true)
    private var testDatabase: OpaquePointer?
    static func getTestDatabase() -> OpaquePointer? {
        return testInstance.testDatabase
    }
    
    private init(testing: Bool) {
        // Create a connection to the database
        do {
            if (testing == true) {
                // Create and connect to in-memory database
                if sqlite3_open("file::memory:", &testDatabase) != SQLITE_OK {
                    print("error opening database")
                } else {
                    print("\n==============")
                    print("test db opened")
                    print("==============\n")
                }
                
            } else {
                // Get full path
                let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                // Define path for database file
                let fileUrl = documentDirectory.appendingPathComponent(K.SQLiteDatabase.dbFilename).appendingPathExtension(K.SQLiteDatabase.dbFileExtension)
                print(fileUrl.path)
                
                // Connect to db or create if doesn't exist
                if sqlite3_open(fileUrl.path, &database) != SQLITE_OK {
                    print("error opening database")
                }
            }
        } catch {
            print("Error connecting to the database: \(error)")
        }
    }
    
    
    private static func runSqlScript(sqlScript: String, database: OpaquePointer?) {
        if let db = database {
            do {
                if sqlite3_exec(db, sqlScript, nil, nil, nil) != SQLITE_OK {
                    let error = String(cString: sqlite3_errmsg(db)!)
                    print("error running sql script: \(error)")
                }
            }
        }
    }
    
    static func createTables(database: OpaquePointer?) {
        let scripts = [ SQLiteTables.userTableSchemaScripts.joined(),
                        SQLiteTables.departmentTableSchemaScripts.joined(),
                        SQLiteTables.categoryTableSchemaScripts.joined(),
                        SQLiteTables.productTableSchemaScripts.joined(),
                        SQLiteTables.productReviewTableSchemaScripts.joined(),
                        SQLiteTables.wishlistTableSchemaScripts.joined(),
                        SQLiteTables.shoppingCartTableSchemaScripts.joined(),
                        SQLiteTables.purchaseOrderTableSchemaScripts.joined(),
                        SQLiteTables.orderItemTableSchemaScripts.joined() ]
        
        for script in scripts {
            runSqlScript(sqlScript: script, database: database)
        }
    }
    
    static func insertData(database: OpaquePointer?) {
        let scripts = [ SQLiteTables.userTableInsertScript,
                        SQLiteTables.departmentTableInsertScript,
                        SQLiteTables.categoryTableInsertScript,
                        SQLiteTables.productTableInsertScript,
                        SQLiteTables.productReviewTableInsertScript,
                        SQLiteTables.wishlistTableInsertScript,
                        SQLiteTables.shoppingCartTableInsertScript,
                        SQLiteTables.purchaseOrderTableInsertScript,
                        SQLiteTables.orderItemTableInsertScript ]
        for script in scripts {
            runSqlScript(sqlScript: script, database: database)
        }
    }
    
}
