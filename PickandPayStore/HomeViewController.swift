//
//  HomeViewController.swift
//  PickandPayStore
//
//  Created by iMac on 4/5/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserSessionManager.shared.getLoggedInUser() != nil {
            print(UserSessionManager.shared.getLoggedInUser()!)
        }
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        PresenterManager.shared.show(vc: .login)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        PresenterManager.shared.show(vc: .register)
    }
    
}
