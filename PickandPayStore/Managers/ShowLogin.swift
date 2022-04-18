//
//  ShowLogin.swift
//  PickandPayStore
//
//  Created by admin on 4/15/22.
//

import UIKit
import SwiftUI

struct UIKitLogin: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIStoryboard(name: K.StoryboardID.main, bundle: nil).instantiateViewController(identifier: K.StoryboardID.loginViewController) as! UIViewController
        return viewController
    }
}

struct UIKitRegister: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIStoryboard(name: K.StoryboardID.main, bundle: nil).instantiateViewController(identifier: K.StoryboardID.registerViewController) as! UIViewController
        return viewController
    }
}
