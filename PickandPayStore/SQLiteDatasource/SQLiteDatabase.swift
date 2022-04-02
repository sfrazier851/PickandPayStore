//
//  SQLiteDatabase.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation
import SQLite3

class SQLiteDatabase {
    private static let sharedInstance = SQLiteDatabase(testing: false)
    private var database: OpaquePointer?
    static func getDatabase() -> OpaquePointer? {
        return sharedInstance.database
    }
    
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
                    print("test database opened")
                }
                
            } else {
                // Get full path
                let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                // Define path for database file
                let fileUrl = documentDirectory.appendingPathComponent(K.SQLiteDatabase.testDbFilename).appendingPathExtension(K.SQLiteDatabase.dbFileExtension)
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
    
    
    private static func createTable(createTableScript: String, database: OpaquePointer?) {
        if let db = database {
            do {
                if sqlite3_exec(db, createTableScript, nil, nil, nil) != SQLITE_OK {
                    let error = String(cString: sqlite3_errmsg(db)!)
                    print("error creating table: \(error)")
                }
            }
        }
    }
    
    static func createTables(database: OpaquePointer?) {
        let scripts = [ SQLiteTables.userTableScripts.joined(),
                        SQLiteTables.departmentTableScripts.joined(),
                        SQLiteTables.categoryTableScripts.joined(),
                        SQLiteTables.productTableScripts.joined(),
                        SQLiteTables.productReviewTableScripts.joined(),
                        SQLiteTables.wishlistTableScripts.joined(),
                        SQLiteTables.shoppingCartTableScripts.joined(),
                        SQLiteTables.purchaseOrderTableScripts.joined(),
                        SQLiteTables.orderItemTableScripts.joined() ]
        
        for script in scripts {
            createTable(createTableScript: script, database: database)
        }
    }
    
}
