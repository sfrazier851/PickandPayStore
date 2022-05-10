//
//  OrderItemTests.swift
//  PickandPayStoreTests
//
//  Created by iMac on 4/20/22.
//

import XCTest
@testable import PickandPayStore
import SQLite3

class OrderItemTests: XCTestCase {

    // (in-memory) test database
    private static var inMemoryTestDB: OpaquePointer?
    
    // called before each test case
    override func setUpWithError() throws {
        OrderItemTests.inMemoryTestDB = SQLiteDatabase.getInMemoryTestDatabase()
        print("\n==============================")
        print("dropping and recreating tables")
        print("==============================")
        // Drop all tables then recreate tables for test database
        SQLiteDatabase.createTables(database: OrderItemTests.inMemoryTestDB)
        // use in-memory db for testing
        User.setTestingTrue()
        Category.setTestingTrue()
        Product.setTestingTrue()
        PurchaseOrder.setTestingTrue()
        OrderItem.setTestingTrue()
    }

    // called after each test case
    override func tearDownWithError() throws {
    }
    
    // called after all tests have been run
    override func tearDown() {
        // Call destructor for sqlite3 test database
        if sqlite3_close_v2(OrderItemTests.inMemoryTestDB!) == 0 {
            print("\n==============")
            print("test db closed")
            print("==============\n")
        } else {
            print("\n==============")
            print("test db NOT closed")
            print("==============\n")
        }
    }
    
    func testOrderItemCreate() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        let created_purchase_order = PurchaseOrder.create(userID: created_user.id, paymentType: "payment_type", shippingAddress: "shipping_address")!
        
        let created_category = Category.create(name: "category_name", imageName: "image_name")!
        let created_product = Product.create(categoryID: created_category.id, name: "product_name", price: 0.0, imageName: "image_name", description: "description")!
        
        let confirm_order_item = OrderItem(id: 1, purchaseOrderID: created_purchase_order.id, productID: created_product.id, purchasePrice: 0.0)
        
        //When
        let new_order_item = OrderItem.create(purchaseOrderID: created_purchase_order.id, productID: created_product.id, purchasePrice: 0.0)
        //Then
        XCTAssert(confirm_order_item == new_order_item, "\(confirm_order_item) and \(String(describing: new_order_item)) should be equal")
    }
    /*
    func testPurchaseOrderGetAll() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: date)
        
        let purchase_order_count = 3
        for x in 1...purchase_order_count {
            PurchaseOrder.create(userID: created_user.id, paymentType: "payment_type", shippingAddress: "shipping_address")
        }
        
        //When
        let query_count = PurchaseOrder.getAll()!.count
        
        //Then
        XCTAssert(purchase_order_count == query_count, "\(purchase_order_count) and \(query_count) should be equal")
    }
    
    func testPurchaseOrderGetByID() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        
        let purchase_order_query_id = 3
        var confirm_purchase_order: PurchaseOrder = PurchaseOrder()
        for x in 1...purchase_order_query_id {
            if x == purchase_order_query_id {
                confirm_purchase_order = PurchaseOrder.create(userID: created_user.id, paymentType: "payment_type\(x)", shippingAddress: "shipping_address\(x)")!
            } else {
                PurchaseOrder.create(userID: created_user.id, paymentType: "payment_type\(x)", shippingAddress: "shipping_address\(x)")
            }
        }
        
        //When
        let query_purchase_order = PurchaseOrder.getByID(purchaseOrderID: purchase_order_query_id)![0]
        
        //Then
        XCTAssert(confirm_purchase_order == query_purchase_order, "\(confirm_purchase_order) and \(query_purchase_order) should be equal")
    }
    
    func testPurchaseOrderGetByUserID() throws {
        //Given
        let created_user = User.create(username: "new_user", email: "email", password: "password", phoneNumber: "phone_number")!
        
        let purchase_order_count = 3
        for x in 1...purchase_order_count {
            PurchaseOrder.create(userID: created_user.id, paymentType: "payment_type", shippingAddress: "shipping_address")
        }
        
        //When
        let query_count = PurchaseOrder.getByUserID(userID: created_user.id)!.count
        
        //Then
        XCTAssert(purchase_order_count == query_count, "\(purchase_order_count) and \(query_count) should be equal")
    }
    */
}
