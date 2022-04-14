//
//  OrderItemDAL.swift
//  PickandPayStore
//
//  Created by iMac on 4/14/22.
//

import Foundation
import SQLite3

class OrderItemDAL: SQLiteDAL {
    
    private let orderitem = OrderItem()
    private let db: OpaquePointer?
    private let convert: (_ orderItemsResultSet: [[String]]) -> [OrderItem]?
    
    init(db: OpaquePointer?, convert: @escaping (_ orderItemsResultSet: [[String]]) -> [OrderItem]?) {
        self.convert = convert
        self.db = db
        super.init(db: db)
    }
    
    // OrderItem DAL (getAllOrderItems, getByPurchaseOrderID, createOrderItem)
    func getAllOrderItems() -> [OrderItem]? {
        guard let orderItemsResultSet = OrderItemDAL.protectedQuery(modelType: orderitem, queryString: "SELECT * FROM OrderItem;") else {
            return nil
        }
        return self.convert(orderItemsResultSet)
    }
    
    func getOrderItemByPurchaseOrderID(purchaseOrderID: Int) -> [OrderItem]? {
        guard let orderItemsResultSet = OrderItemDAL.protectedQuery(modelType: orderitem, queryString: "SELECT * FROM OrderItem WHERE purchaseOrderID = '\(purchaseOrderID)';") else {
            return nil
        }
        return self.convert(orderItemsResultSet)
    }
    
    func createOrderItem(purchaseOrderID: Int, productID: Int, purchasePrice: Float) -> Bool? {
        guard let db = self.db else {
            return nil
        }
        var success = true
        let insertStatementString = "INSERT INTO OrderItem ( purchaseOrderID, productID, purchasePrice ) VALUES ( ?, ?, ?)"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(purchaseOrderID))
            sqlite3_bind_int(insertStatement, 2, Int32(productID))
            sqlite3_bind_double(insertStatement, 3, Double(purchasePrice))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
                success = false
            }
            sqlite3_finalize(insertStatement)
        }
        return success
    }
}
