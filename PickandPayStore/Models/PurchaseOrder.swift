//
//  PurchaseOrder.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct PurchaseOrder: Equatable {
    var id: Int = 0
    var userID: Int = 0
    var paymentType: String = ""
    var date_purchased: String = ""
    var shipping_address: String = ""
    var shipping_longitude: String = ""
    var shipping_latitude: String = ""
    
    private static var purchaseOrderDAL: PurchaseOrderDAL? = PurchaseOrderDAL(db: SQLiteDatabase.getDatabase(), convert: convert)
    
    static func setTestingTrue() {
        purchaseOrderDAL = PurchaseOrderDAL(db: SQLiteDatabase.getInMemoryTestDatabase(), convert: convert)
    }
    
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
            purchaseOrder.shipping_address = columns[4]
            purchaseOrder.shipping_longitude = columns[5]
            purchaseOrder.shipping_latitude = columns[6]
            
            purchaseOrders.append(purchaseOrder)
        }
        return purchaseOrders
    }
    
    static func getAll() -> [PurchaseOrder]? {
        guard let purchaseOrderDAL = purchaseOrderDAL else {
            return nil
        }
        return purchaseOrderDAL.getAllPurchaseOrders()
    }
    
    static func getByID(purchaseOrderID: Int) -> [PurchaseOrder]? {
        guard let purchaseOrderDAL = purchaseOrderDAL else {
            return nil
        }
        return purchaseOrderDAL.getPurchaseOrderByID(purchaseOrderID: purchaseOrderID)
    }
    
    static func getByUserID(userID: Int) -> [PurchaseOrder]? {
        guard let purchaseOrderDAL = purchaseOrderDAL else {
            return nil
        }
        return purchaseOrderDAL.getPurchaseOrdersByUserID(userID: userID)
    }
    
    static func create(userID: Int, paymentType: String, shippingAddress: String) -> PurchaseOrder? {
        guard let purchaseOrderDAL = purchaseOrderDAL else {
            return nil
        }
        return purchaseOrderDAL.createPurchaseOrder(userID: userID, paymentType: paymentType, shippingAddress: shippingAddress)
    }
}
