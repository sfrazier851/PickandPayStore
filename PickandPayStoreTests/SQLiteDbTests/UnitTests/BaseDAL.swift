//
//  BaseDAL.swift
//  PickandPayStoreTests
//
//  Created by iMac on 4/17/22.
//
import XCTest
@testable import PickandPayStore
import SQLite3

private struct testModelType1 {
    var id = 0
    var name = ""
    var price = 0.0
    var in_stock = false
    
    static var testing = false
}

private struct testModelType2 {
    static var testing = false
    
    var in_stock = false
    var price = 0.0
    var id = 0
    var name = ""
}

class BaseDAL: XCTestCase {
    // initialize SQLiteDAL instance without db instance
    private static let baseSqliteDAL = SQLiteDAL(db: nil)
    // initialize testModelType instance
    private let testModel1 = testModelType1()
    private let testModel2 = testModelType2()
    
    func testGetColumnTypes() throws {
        //Given
        let confirm_columnTypes1 = ["Int","String","Double","Bool"]
        let confirm_columnTypes2 = ["Bool", "Double", "Int", "String"]
        
        //When
        let columnTypes1 = SQLiteDAL.getColumnTypes(modelType: testModel1)
        let columnTypes2 = SQLiteDAL.getColumnTypes(modelType: testModel2)
        
        //Then
        XCTAssertTrue(confirm_columnTypes1 == columnTypes1, "\(confirm_columnTypes1) and \(columnTypes1) should have identical elements")
        XCTAssertTrue(confirm_columnTypes2 == columnTypes2, "\(confirm_columnTypes2) and \(columnTypes2) should have identical elements")
    }
}
