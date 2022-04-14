//
//  OrderItem.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct OrderItem {
    var id: Int = 0
    var purchaseOrderID: Int = 0
    var productID: Int = 0
    var purchasePrice: Float = 0.0
    
    static let orderItemDAL = { () -> OrderItemDAL? in
        if let db = SQLiteDatabase.getDatabase() {
            return OrderItemDAL(db: db, convert: convert)
        }
        return nil
    }()
    
    // Convert query result set to Array of OrderItem
    static func convert(orderItemsResultSet: [[String]]) -> [OrderItem]? {
        var orderItems = [OrderItem]()
        for orderItem_row in orderItemsResultSet {
            let columns = orderItem_row
            
            var orderItem = OrderItem()
            orderItem.id = Int(columns[0])!
            orderItem.purchaseOrderID = Int(columns[1])!
            orderItem.productID = Int(columns[2])!
            orderItem.purchasePrice = Float(columns[3])!
            
            orderItems.append(orderItem)
        }
        return orderItems
    }
    
    static func getAll() -> [OrderItem]? {
        guard let orderItemDAL = orderItemDAL else {
            return nil
        }
        return orderItemDAL.getAllOrderItems()
    }
    
    static func getByPurchaseOrderID(purchaseOrderID: Int) -> [OrderItem]? {
        guard let orderItemDAL = orderItemDAL else {
            return nil
        }
        return orderItemDAL.getOrderItemByPurchaseOrderID(purchaseOrderID: purchaseOrderID)
    }
    
    static func create(purchaseOrderID: Int, productID: Int, purchasePrice: Float) -> Bool? {
        guard let orderItemDAL = orderItemDAL else {
            return nil
        }
        return orderItemDAL.createOrderItem(purchaseOrderID: purchaseOrderID, productID: productID, purchasePrice: purchasePrice)
    }
}
