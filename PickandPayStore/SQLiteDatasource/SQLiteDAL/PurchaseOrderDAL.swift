//
//  PurchaseOrderDAL.swift
//  PickandPayStore
//
//  Created by iMac on 4/14/22.
//

import Foundation
import SQLite3

class PurchaseOrderDAL: SQLiteDAL {
    
    private let purchaseorder = PurchaseOrder()
    private let db: OpaquePointer?
    // function defined in corresponding model struct
    private let convert: (_ purchaseOrderResultSet: [[String]]) -> [PurchaseOrder]?
    
    init(db: OpaquePointer?, convert: @escaping (_ purchaseOrderResultSet: [[String]]) -> [PurchaseOrder]?) {
        self.convert = convert
        self.db = db
        super.init(db: db)
    }
    
    // PurchaseOrder DAL (getAllPurchaseOrders, getPurchaseOrdersByUserID, createPurchaseOrder)
    func getAllPurchaseOrders() -> [PurchaseOrder]? {
        guard let purchaseOrderResultSet = PurchaseOrderDAL.protectedQuery(modelType: purchaseorder, queryString: "SELECT * FROM PurchaseOrder;") else {
            return nil
        }
        return self.convert(purchaseOrderResultSet)
    }
    
    func getPurchaseOrderByID(purchaseOrderID: Int) -> [PurchaseOrder]? {
        guard let purchaseOrderResultSet = PurchaseOrderDAL.protectedQuery(modelType: purchaseorder, queryString: "SELECT * FROM PurchaseOrder WHERE ID = '\(purchaseOrderID)';") else {
            return nil
        }
        return self.convert(purchaseOrderResultSet)
    }
    
    func getPurchaseOrdersByUserID(userID: Int) -> [PurchaseOrder]? {
        guard let purchaseOrderResultSet = PurchaseOrderDAL.protectedQuery(modelType: purchaseorder, queryString: "SELECT * FROM PurchaseOrder WHERE userID = '\(userID)';") else {
            return nil
        }
        return self.convert(purchaseOrderResultSet)
    }
    
    func updatePurchaseOrder(purchaseOrder: PurchaseOrder) -> PurchaseOrder? {
        guard let db = self.db else {
            return nil
        }
        let purchaseOrderID = purchaseOrder.id
        let paymentType = purchaseOrder.paymentType
        let shippingAddress = purchaseOrder.shipping_address
        let shippingLongitude = purchaseOrder.shipping_longitude
        let shippingLatitude = purchaseOrder.shipping_latitude
        
        let updateStatementString = "UPDATE PurchaseOrder SET shippingLongitude = '\(shippingLongitude)', shippingLatitude = '\(shippingLatitude)' WHERE ID = '\(purchaseOrderID)';"
        
        if sqlite3_exec(db, updateStatementString, nil, nil, nil) != SQLITE_OK {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("error running sql script: \(error)")
        }
        
        return PurchaseOrder.getByID(purchaseOrderID: purchaseOrderID)![0]
    }
    
    func createPurchaseOrder(userID: Int, paymentType: String, shippingAddress: String) -> PurchaseOrder? {
        guard let db = self.db else {
            return nil
        }
        let insertStatementString = "INSERT INTO PurchaseOrder ( userID, paymentType, shippingAddress) VALUES ( ?, ?, ?)"
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(userID))
            sqlite3_bind_text(insertStatement, 2, NSString(string: paymentType).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, NSString(string: shippingAddress).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\n INSERT statement is not prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
        
        let newPurchaseOrderID = PurchaseOrderDAL.protectedGetLatestInsertId()!
        return PurchaseOrder.getByID(purchaseOrderID: newPurchaseOrderID)![0]
    }
}
