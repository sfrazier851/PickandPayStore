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
    
    private static var testing: Bool = false
    static func setTestingTrue() { PurchaseOrder.testing = true }

    private static let purchaseOrderDAL = { () -> PurchaseOrderDAL? in
        if PurchaseOrder.testing == true {
            if let db = SQLiteDatabase.getInMemoryTestDatabase() {
                return PurchaseOrderDAL(db: db, convert: convert)
            }
        } else {
            if let db = SQLiteDatabase.getDatabase() {
                return PurchaseOrderDAL(db: db, convert: convert)
            }
        }
        return nil
    }()
    
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
    
    static func update(purchaseOrder: PurchaseOrder) -> PurchaseOrder? {
        guard let purchaseOrderDAL = purchaseOrderDAL else {
            return nil
        }
        return purchaseOrderDAL.updatePurchaseOrder(purchaseOrder: purchaseOrder)
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
