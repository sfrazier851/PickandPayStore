//
//  SQLiteDatabase.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation
import SQLite3

class SQLiteDatabase {
    
    private enum testing {
        case none
        case unit
        case integration
    }
    
    // application database instance
    private static let sharedInstance = SQLiteDatabase(testing: .none)
    private var database: OpaquePointer?
    private static var dbPath: String = getDbFilePath(dbFilename: K.SQLiteDatabase.dbFilename, dbFileExtension: K.SQLiteDatabase.dbFileExtension)
    static func getDbPath() -> String { return dbPath }
    static func getDatabase() -> OpaquePointer? {
        guard let db = sharedInstance.database else {
            return nil
        }
        return db
    }
    
    // integration testing database instance
    private static let integrationTestInstance = SQLiteDatabase(testing: .integration)
    private var integrationTestDatabase: OpaquePointer?
    private static var integrationDbPath: String = ""
    static func getIntegrationTestDbPath() -> String { return integrationDbPath }
    static func getIntegrationTestDatabase() -> OpaquePointer? {
        return integrationTestInstance.integrationTestDatabase
    }
    
    // unit testing database instance
    private static let unitTestInstance = SQLiteDatabase(testing: .unit)
    private var unitTestDatabase: OpaquePointer?
    static func getUnitTestDatabase() -> OpaquePointer? {
        return unitTestInstance.unitTestDatabase
    }
    
    private init(testing: testing) {
        // Create a connection to the database
        switch testing {
            case .unit:
                // Create and connect to in-memory database for unit tests
                if sqlite3_open("file::memory:", &unitTestDatabase) != SQLITE_OK {
                    print("error opening database")
                } else {
                    print("\n==============")
                    print("test db opened")
                    print("==============\n")
                }
            case .integration:
                // Get integration test db file path
                let dbFilePath = SQLiteDatabase.getDbFilePath(dbFilename: K.SQLiteDatabase.testDbFilename, dbFileExtension: K.SQLiteDatabase.dbFileExtension)
                SQLiteDatabase.integrationDbPath = dbFilePath
                print(dbFilePath)
                // Connect to db or create if doesn't exist for integration tests
                if sqlite3_open(dbFilePath, &integrationTestDatabase) != SQLITE_OK {
                    print("error opening database")
                }
            case .none:
                // Get application db file path
                let dbFilePath = SQLiteDatabase.getDbFilePath(dbFilename: K.SQLiteDatabase.dbFilename, dbFileExtension: K.SQLiteDatabase.dbFileExtension)
                SQLiteDatabase.dbPath = dbFilePath
                print(dbFilePath)
                // Connect to db or create if doesn't exist for application
                if sqlite3_open(dbFilePath, &database) != SQLITE_OK {
                    print("error opening database")
                }
        }
    }
    
    private static func getDbFilePath(dbFilename: String, dbFileExtension: String) -> String {
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
