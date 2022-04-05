//
//  PurchaseOrder.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct PurchaseOrder {
    var id: Int = 0
    var userID: Int = 0
    var paymentType: String = ""
    var date_purchased: String = ""
    
    static let purchaseorder = PurchaseOrder()
    
    // Convert query result set to Array of PurchaseOrder
    static func convert(purchaseOrderResultSet: [[String]]) -> [PurchaseOrder]? {
        var purchaseOrders = [PurchaseOrder]()
        for purchaseOrder_row in purchaseOrderResultSet {
            let columns = purchaseOrder_row
            
            var purchaseOrder = PurchaseOrder()
            purchaseOrder.id = Int(columns[0])!
            purchaseOrder.userID = Int(columns[1])!
            purchaseOrder.paymentType = columns[2]
            purchaseOrder.date_purchased = columns[3]
            
            purchaseOrders.append(purchaseOrder)
        }
        return purchaseOrders
    }
    
    static func getAll() -> [PurchaseOrder]? {
        return SQLiteDAL.getAllPurchaseOrders()
    }
    
    static func getByID(purchaseOrderID: Int) -> [PurchaseOrder]? {
        return SQLiteDAL.getPurchaseOrderByID(purchaseOrderID: purchaseOrderID)
    }
    
    static func getByUserID(userID: Int) -> [PurchaseOrder]? {
        return SQLiteDAL.getPurchaseOrdersByUserID(userID: userID)
    }
    
    static func create(userID: Int, paymentType: String) -> Bool? {
        return SQLiteDAL.createPurchaseOrder(userID: userID, paymentType: paymentType)
    }
}
