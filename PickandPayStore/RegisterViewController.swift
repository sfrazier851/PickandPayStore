//
//  RegisterViewController.swift
//  PickandPayStore
//
//  Created by iMac on 4/5/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var backToHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func backToHomeButtonTapped(_ sender: Any) {
        PresenterManager.shared.show(vc: .home)
    }
    
}
