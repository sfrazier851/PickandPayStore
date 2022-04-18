//
//  SQLiteTables.swift
//  PickAndPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

class SQLiteTables {
    
   private static var dropUserTable = "DROP TABLE IF EXISTS User;"
   private static var createUserTable = """
             CREATE TABLE IF NOT EXISTS User
             (ID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
             username TEXT NOT NULL,
             email TEXT NOT NULL,
             password TEXT NOT NULL,
             phone_number TEXT NOT NULL,
             balance DECIMAL(10,3) NOT NULL);
             """
    private static var insertIntoUserTable = """
             INSERT INTO User ( username, email, password, phone_number, balance )
             VALUES ('tester1', 't1@gmail.com', 'Password!', 9812778590, 0.000),
                    ('gary', 'gary@gmail.com', 'Gassword!', 3242334560, 0.000),
                    ('admin', 'admin@gmail.com', 'superSecret!', 2393648760, 0.000);
             """
    static var userTableSchemaScripts = [dropUserTable, createUserTable]
    static var userTableInsertScript = insertIntoUserTable
    
    
   
    private static var dropCategoryTable = "DROP TABLE IF EXISTS Category;"
    private static var createCategoryTable = """
             CREATE TABLE IF NOT EXISTS Category
             (ID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
             name TEXT NOT NULL,
             imageName TEXT NOT NULL);
             """
    private static var insertIntoCategoryTable = """
             INSERT INTO Category ( name, imageName)
             VALUES ( 'Spaceships', 'x-wing' ),
             ( 'Ground', 'speeder' ),
             ( 'Droids', 'buddy' );
             """
    static var categoryTableSchemaScripts = [dropCategoryTable, createCategoryTable]
    static var categoryTableInsertScript = insertIntoCategoryTable
    
    
    
    private static var dropProductTable = "DROP TABLE IF EXISTS Product;"
    private static var createProductTable = """
             CREATE TABLE IF NOT EXISTS Product
             (ID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
             categoryID INTEGER NOT NULL,
             name TEXT NOT NULL,
             price DECIMAL(10,3) NOT NULL,
             imageName TEXT NOT NULL,
             description TEXT,
             FOREIGN KEY(categoryID) REFERENCES Category(ID));
             """
            //description TEXT NOT NULL,
    private static var insertIntoProductTable = """
             INSERT INTO Product ( categoryID, name, price, imageName, description )
             VALUES ( 1, 'Falcon', 190008, 'falcon', ''),
             ( 1, 'Ghost', 95000, 'ghost', ''),
             ( 1, 'SA-Bomber',86500,'sa-bomber', ''),
             ( 1, 'Striker',299000,'striker', ''),
             ( 1, 'Star Destroyer', 179400, 'star-destroyer', ''),
             ( 1, 'X-Wing', 123400, 'x-wing', ''),
             ( 1, 'Y-Wing', 111876, 'y-wing', ''),
             ( 2, 'AT-AT', 54005, 'at-at' , ''),
             ( 2, 'AT-AP', 35000, 'at-ap', ''),
             ( 2, 'AT-ST', 86500, 'at-st', ''),
             ( 2, 'AT-SW', 99000, 'at-sw', ''),
             ( 2, 'AT-TE', 179409, 'at-te', ''),
             ( 2, 'Speeder', 23345, 'speeder', ''),
             ( 2, 'Tank', 111110, 'tank', ''),
             ( 3, 'Bb8', 196.75, 'bb8', '' ),
             ( 3, 'Buddy', 9000, 'buddy', ''),
             ( 3, 'C3po', 8000, 'c3po', ''),
             ( 3, 'Death Star Droid', 29000, 'death-star-droid', ''),
             ( 3, 'Destroyer', 19400, 'destroyer', ''),
             ( 3, 'K2so', 3400, 'k2so', ''),
             ( 3, 'R5d4', 1876, 'r5d4', '');
             """
    static var productTableSchemaScripts = [dropProductTable, createProductTable]
    static var productTableInsertScript = insertIntoProductTable
    
    
    
    private static var dropProductReviewTable = "DROP TABLE IF EXISTS ProductReview;"
    private static var createProductReviewTable = """
             CREATE TABLE IF NOT EXISTS ProductReview
             (ID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
             userID INTEGER NOT NULL,
             productID INTEGER NOT NULL,
             review TEXT NOT NULL,
             title TEXT NOT NULL,
             FOREIGN KEY(userID) REFERENCES User(ID),
             FOREIGN KEY(productID) REFERENCES Product(ID));
             """
    private static var insertIntoProductReviewTable = """
             INSERT INTO ProductReview ( userID, productID, review, title )
             VALUES ( 1, 1, "Works great! Would recommend to all my friends.", "Love this"),
                    ( 2, 1, "Meh, it was alright.", "Not the worst");
             """
    static var productReviewTableSchemaScripts = [dropProductReviewTable, createProductReviewTable]
    static var productReviewTableInsertScript = insertIntoProductReviewTable
    
    
    private static var dropWishlistTable = "DROP TABLE IF EXISTS Wishlist;"
    private static var createWishlistTable = """
             CREATE TABLE IF NOT EXISTS Wishlist
             (ID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
             userID INTEGER NOT NULL,
             productID INTEGER NOT NULL,
             date_added TEXT DEFAULT (date()) NOT NULL,
             FOREIGN KEY(userID) REFERENCES User(ID),
             FOREIGN KEY(productID) REFERENCES Product(ID));
             """
    private static var insertIntoWishlistTable = """
             INSERT INTO Wishlist ( userID, productID, date_added )
             VALUES ( 1, 1, '2022-03-29' ),
                    ( 1, 2, '2022-03-28' );
             """
    static var wishlistTableSchemaScripts = [dropWishlistTable, createWishlistTable]
    static var wishlistTableInsertScript = insertIntoWishlistTable
    
    
    
    private static var dropShoppingCartTable = "DROP TABLE IF EXISTS ShoppingCart;"
    private static var createShoppingCartTable = """
             CREATE TABLE IF NOT EXISTS ShoppingCart
             (ID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
             userID INTEGER NOT NULL,
             productID INTEGER NOT NULL,
             date_added TEXT DEFAULT (date()) NOT NULL,
             FOREIGN KEY(userID) REFERENCES User(ID),
             FOREIGN KEY(productID) REFERENCES Product(ID));
             """
    private static var insertIntoShoppingCartTable = """
             INSERT INTO ShoppingCart ( userID, productID, date_added )
             VALUES ( 1, 1, '2022-03-29' ),
                    ( 1, 2, '2022-03-28' );
             """
    static var shoppingCartTableSchemaScripts = [dropShoppingCartTable, createShoppingCartTable]
    static var shoppingCartTableInsertScript = insertIntoShoppingCartTable
    
    
    
    private static var dropPurchaseOrderTable = "DROP TABLE IF EXISTS PurchaseOrder;"
    private static var createPurchaseOrderTable = """
             CREATE TABLE IF NOT EXISTS PurchaseOrder
             (ID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
             userID INTEGER NOT NULL,
             paymentType TEXT NOT NULL,
             date_purchased TEXT DEFAULT (date()) NOT NULL,
             shippingAddress TEXT NOT NULL,
             shippingLongitude TEXT DEFAULT "null" NULL,
             shippingLatitude TEXT DEFAULT "null" NULL,
             FOREIGN KEY(userID) REFERENCES User(ID));
             """
    private static var insertIntoPurchaseOrderTable = """
             INSERT INTO PurchaseOrder ( userID, paymentType, date_purchased, shippingAddress )
             VALUES ( 1, "COD", '2022-03-29', '1600 Amphitheatre Parkway, Mountain View, CA' ),
                    ( 1, "CC", '2022-03-28' , '55 Brooksby Village Drive, Danvers, MA');
             """
    static var purchaseOrderTableSchemaScripts = [dropPurchaseOrderTable, createPurchaseOrderTable]
    static var purchaseOrderTableInsertScript = insertIntoPurchaseOrderTable
    
    
    private static var dropOrderItemTable = "DROP TABLE IF EXISTS OrderItem;"
    private static var createOrderItemTable = """
             CREATE TABLE IF NOT EXISTS OrderItem
             (ID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
             purchaseOrderID INTEGER NOT NULL,
             productID INTEGER NOT NULL,
             purchasePrice DECIMAL(10,3) NOT NULL,
             FOREIGN KEY(purchaseOrderID) REFERENCES PurchaseOrder(ID),
             FOREIGN KEY(productID) REFERENCES Product(ID));
             """
    private static var insertIntoOrderItemTable = """
             INSERT INTO OrderItem ( purchaseOrderID, productID, purchasePrice )
             VALUES ( 1, 1, 10.23 ),
                    ( 1, 2, 25.60 ),
                    ( 2, 1, 10.23 );
             """
    static var orderItemTableSchemaScripts = [dropOrderItemTable, createOrderItemTable]
    static var orderItemTableInsertScript = insertIntoOrderItemTable
}
