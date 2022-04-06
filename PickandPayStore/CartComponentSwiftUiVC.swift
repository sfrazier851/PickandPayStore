//
//  CartComponentSwiftUiVC.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/1/22.
//

import UIKit
import SwiftUI

class CartComponentSwiftUiVC: UIViewController {

    // This outlet is used to connect with the main view controller.
    @IBOutlet weak var theContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the UIHostingController variable.
        let swiftUIView = UIHostingController(rootView: PickCategoryView())
        addChild(swiftUIView)
        swiftUIView.view.frame = theContainer.bounds
        theContainer.addSubview(swiftUIView.view)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
