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
        // Comment out after first run.
        SQLiteDatabase.createTables()
        
        
        // Example db usage:
        print()
        print("=======================")
        print("  example db calls:  ")
        print("=======================")
        User.create(username: "insert_user", email: "i@gmail.com", password: "Password!", phoneNumber: "8888888888")
        for user in User.getAll()! { print(user) }
        
        print("\nget user by email: admin@gmail.com")
        for user in User.getByEmail(email: "admin@gmail.com")! { print(user) }
        
        print("\nget user by username: gary")
        for user in User.getByUsername(username: "gary")! { print(user) }
        
        print("\n=======================")
        print("  creating Department  ")
        print("=======================")
        Department.create(name: "Arts & Crafts", imageName: "imArtsCrafts")
        for department in Department.getAll()! { print(department) }
        
        print("\nget departments by name")
        for department in Department.getByName(name: "Electronics")! { print(department) }
        
        print("\n=======================")
        print("  creating Category  ")
        print("=======================")
        Category.create(departmentID: 10, name: "Sewing", imageName: "imSewing")
        for category in Category.getAll()! { print(category) }
        
        print("\nget categories by name")
        for category in Category.getByName(name: "Sewing")! { print(category) }
        
        
        print("\n=======================")
        print("  creating Product  ")
        print("=======================")
        Product.create(departmentID: 10, categoryID: 9, name: "Hand Sewing needles (x25)", price: 0.97, imageName: "imHandSewingNeedles")
        for product in Product.getAll()! { print(product) }
        
        print("\nget product by name")
        for product in Product.getByName(name: "Hand Sewing needles (x25)")! { print(product) }
        
        print("\n=======================")
        print("  adding to Wishlist  ")
        print("=======================")
        Wishlist.create(userID: 1, productID: 1)
        for product in Wishlist.getAll()! { print(product) }
        
        print("\nget wishlist by user id")
        for product in Wishlist.getByUserID(userID: 1)! { print(product) }
        
        print("\n=======================")
        print("  adding to ShoppingCart ")
        print("=======================")
        ShoppingCart.create(userID: 1, productID: 1)
        ShoppingCart.create(userID: 1, productID: 2)
        
        for product in ShoppingCart.getAll()! { print(product) }
        
        print("\nget shopping cart by user id")
        for product in ShoppingCart.getByUserID(userID: 1)! { print(product) }
        
        print("\n=======================")
        print("  adding to PurchaseOrder ")
        print("=======================")
        PurchaseOrder.create(userID: 1, paymentType: "COD")
        
        for order in PurchaseOrder.getAll()! { print(order) }
        
        print("\n get purchase order by user id")
        for order in PurchaseOrder.getByUserID(userID: 1)! { print(order) }
        
        print("\n=======================")
        print("  adding to OrderItems ")
        print("=======================")
        
        let product1 = Product.getByID(productID: 1)![0]
        OrderItem.create(purchaseOrderID: 1, productID: 1, purchasePrice: product1.price)
        let product2 = Product.getByID(productID: 2)![0]
        OrderItem.create(purchaseOrderID: 1, productID: 2, purchasePrice: product2.price)
        
        for orderitem in OrderItem.getByPurchaseOrderID(purchaseOrderID: 1)! { print(orderitem) }
        
        let userID = PurchaseOrder.getByID(purchaseOrderID: 1)![0].userID
        print(User.getByID(userID: userID)!)
        
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

