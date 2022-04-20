//
//  SQLiteDatabase.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation
import SQLite3

class SQLiteDatabase {
    
    private enum db_type {
        case applicationDB
        //case inMemoryTestingDB
        case testingDB
    }
    
    // application database instance
    private static let applicationInstance = SQLiteDatabase(dbType: .applicationDB)
    private var appDatabase: OpaquePointer?
    static func getDatabase() -> OpaquePointer? {
        guard let db = applicationInstance.appDatabase else {
            return nil
        }
        return db
    }
    
    // testing db (file)
    private static let testInstance = SQLiteDatabase(dbType: .testingDB)
    private var testDatabase: OpaquePointer?
    static func getTestDatabase() -> OpaquePointer? {
        return testInstance.testDatabase
    }
    
    // testing db (in memory)
    //private static let inMemoryTestInstance = SQLiteDatabase(dbType: .inMemoryTestingDB)
    private static var inMemoryTestDatabase: OpaquePointer?
    static func getInMemoryTestDatabase() -> OpaquePointer? {
        // if getDbURLString returns "" (empty string) the db exists in memory
        // else create and return a new in memory database
        if "" == getDbURLString(database: inMemoryTestDatabase) {
            return inMemoryTestDatabase
        } else {
            var inMemoryDb: OpaquePointer?
            // Create and connect to in-memory database for tests
            if sqlite3_open("file::memory:", &inMemoryDb) != SQLITE_OK {
                print("error opening database")
            } else {
                print("\n==============")
                print("test db opened")
                print("==============\n")
            }
            inMemoryTestDatabase = inMemoryDb
            return inMemoryTestDatabase
        }
    }
    
    private init(dbType: db_type) {
        // Create a connection to the database
        switch dbType {
            /*case .inMemoryTestingDB:
                // Create and connect to in-memory database for integration tests
                if sqlite3_open("file::memory:", &SQLiteDatabase.inMemoryTestDatabase) != SQLITE_OK {
                    print("error opening database")
                } else {
                    print("\n==============")
                    print("test db opened")
                    print("==============\n")
                }*/
            case .testingDB:
                // Get test db (file-based) path
                let dbFilePath = SQLiteDatabase.createDbFilePathFromConfig(dbFilename: K.SQLiteDatabase.testDbFilename, dbFileExtension: K.SQLiteDatabase.dbFileExtension)
                print(dbFilePath)
                // Connect to db or create if doesn't exist
                if sqlite3_open(dbFilePath, &testDatabase) != SQLITE_OK {
                    print("error opening database")
                }
            case .applicationDB:
                // Get application db file path
                let dbFilePath = SQLiteDatabase.createDbFilePathFromConfig(dbFilename: K.SQLiteDatabase.dbFilename, dbFileExtension: K.SQLiteDatabase.dbFileExtension)
                print(dbFilePath)
                // Connect to db or create if doesn't exist
                if sqlite3_open(dbFilePath, &appDatabase) != SQLITE_OK {
                    print("error opening database")
                }
        }
    }
    
    private static func createDbFilePathFromConfig(dbFilename: String, dbFileExtension: String) -> String {
        do {
            // Get full path
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            // Define path for database file
            let fileUrl = documentDirectory.appendingPathComponent(dbFilename).appendingPathExtension(dbFileExtension)
            
            return fileUrl.path
        } catch {
            print("Error getting db file path: \(error)")
        }
        return ""
    }
    
    private static func runSqlScript(sqlScript: String, database: OpaquePointer?) {
        guard let db = database else {
            return
        }
        if sqlite3_exec(db, sqlScript, nil, nil, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("error running sql script: \(error)")
        }
    }
    
    static func getDbURLString(database: OpaquePointer?) -> String? {
        // return nil if in memory database does not exist
        guard let pointer = sqlite3_db_filename(database, nil) else {
            return nil
        }
        // if the database exists in memory, urlString will be empty string:
        // https://sqlite.org/c3ref/db_filename.html
        // else it will return the database file full path as string
        let urlString = String(cString: pointer)
        return urlString
    }
    
    static func createTables(database: OpaquePointer?) {
        guard let db = database else {
            return
        }
        let scripts = [ SQLiteTables.userTableSchemaScripts.joined(),
                        SQLiteTables.categoryTableSchemaScripts.joined(),
                        SQLiteTables.productTableSchemaScripts.joined(),
                        SQLiteTables.productReviewTableSchemaScripts.joined(),
                        SQLiteTables.wishlistTableSchemaScripts.joined(),
                        SQLiteTables.shoppingCartTableSchemaScripts.joined(),
                        SQLiteTables.purchaseOrderTableSchemaScripts.joined(),
                        SQLiteTables.orderItemTableSchemaScripts.joined() ]
        
        for script in scripts {
            runSqlScript(sqlScript: script, database: db)
        }
    }
    
    static func insertData(database: OpaquePointer?) {
        guard let db = database else {
            return
        }
        let scripts = [ SQLiteTables.userTableInsertScript,
                        SQLiteTables.categoryTableInsertScript,
                        SQLiteTables.productTableInsertScript,
                        SQLiteTables.productReviewTableInsertScript,
                        SQLiteTables.wishlistTableInsertScript,
                        SQLiteTables.shoppingCartTableInsertScript,
                        SQLiteTables.purchaseOrderTableInsertScript,
                        SQLiteTables.orderItemTableInsertScript ]
        for script in scripts {
            runSqlScript(sqlScript: script, database: db)
        }
    }
    
}
