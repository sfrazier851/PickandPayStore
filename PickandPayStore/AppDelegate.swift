//
//  AppDelegate.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 3/29/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        //NOTE: this recreates the database if already exists.
        // Comment out if changes were made to database.
        // THEN add comments after first run.
       let db = SQLiteDatabase.getDatabase()
       SQLiteDatabase.createTables(database: db)
        SQLiteDatabase.insertData(database: db)
        
        
        // If database file exists don't recreate and insert data
        
//        if(!FileManager.default.fileExists(atPath: SQLiteDatabase.getDbPath())) {
//            print("creating db")
//            let db = SQLiteDatabase.getDatabase()
//            SQLiteDatabase.createTables(database: db)
//            SQLiteDatabase.insertData(database: db)
//        }
        
        
        //for po in PurchaseOrder.getByUserID(userID: 1)! { print(po) }
        
        // Example db usage:
//        print()
//        print("=======================")
//        print("  example db calls:  ")
//        print("=======================")
//        User.create(username: "insert_user", email: "i@gmail.com", password: "Password!", phoneNumber: "8888888888")
//        for user in User.getAll()! { print(user) }
//
//        print("\nget user by email: admin@gmail.com")
//        for user in User.getByEmail(email: "admin@gmail.com")! { print(user) }
//
//        print("\nget user by username: gary")
//        for user in User.getByUsername(username: "gary")! { print(user) }
//
//        print("\n=======================")
//        print("  creating Category  ")
//        print("=======================")
//        CategoryM.create(name: "Sewing", imageName: "imSewing")
//        for category in CategoryM.getAll()! { print(category) }
//
//        print("\nget categories by name")
//        for category in CategoryM.getByName(name: "Sewing")! { print(category) }
//
//
//        print("\n=======================")
//        print("  creating Product  ")
//        print("=======================")
//        ProductM.create(categoryID: 9, name: "Hand Sewing needles (x25)", price: 0.97, imageName: "imHandSewingNeedles", description: "Set of 25 assorted hand needles. Includes betweens, darners, sharps and embroidery needles.")
//        for product in ProductM.getAll()! { print(product) }
//
//        print("\nget product by name")
//        for product in ProductM.getByName(name: "Hand Sewing needles (x25)")! { print(product) }
//
//        print("\n=======================")
//        print("  adding to Wishlist  ")
//        print("=======================")
//        Wishlist.create(userID: 2, productID: 1)
//        print("\ngetting all wishlist items")
//        for product in Wishlist.getAll()! { print(product) }
//
//        print("\nget wishlist by user id")
//        for product in Wishlist.getByUserID(userID: 1)! { print(product) }
//
//        print("\n=======================")
//        print("  adding to ShoppingCart ")
//        print("=======================")
//        ShoppingCart.create(userID: 2, productID: 1)
//        ShoppingCart.create(userID: 2, productID: 2)
//
//        for product in ShoppingCart.getAll()! { print(product) }
//
//        print("\nget shopping cart by user id")
//        for product in ShoppingCart.getByUserID(userID: 2)! { print(product) }
//
//        print("\n=======================")
//        print("  adding to PurchaseOrder ")
//        print("=======================")
//        PurchaseOrder.create(userID: 1, paymentType: "COD")
//
//        for order in PurchaseOrder.getAll()! { print(order) }
//
//        print("\n get purchase order by user id")
//        for order in PurchaseOrder.getByUserID(userID: 1)! { print(order) }
//
//        print("\n=======================")
//        print("  adding to OrderItems ")
//        print("=======================")
//
//        let product1 = ProductM.getByID(productID: 1)![0]
//        OrderItem.create(purchaseOrderID: 1, productID: 1, purchasePrice: product1.price)
//        let product2 = ProductM.getByID(productID: 2)![0]
//        OrderItem.create(purchaseOrderID: 1, productID: 2, purchasePrice: product2.price)
//
//        for orderitem in OrderItem.getByPurchaseOrderID(purchaseOrderID: 1)! { print(orderitem) }
//
//        let userID = PurchaseOrder.getByID(purchaseOrderID: 1)![0].userID
//        print(User.getByID(userID: userID)!)
//
//
//        print("\n=======================")
//        print(" adding to ProductReviews ")
//        print("=======================")
//
//        ProductReview.create(userID: 2, productID: 2, review: "Terrible, wouldn't recommend. It broke 3 weeks after it arrived.")
//
//        print("\nget all product reviews")
//        for review in ProductReview.getAll()! { print(review) }
//
//        let product = ProductM.getByID(productID: 1)![0]
//        print("\nget all product reviews for product: \(product.name).")
//        for review in ProductReview.getByProductID(productID: product.id)! { print(review) }
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

