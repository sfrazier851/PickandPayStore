//
//  LoginViewController.swift
//  PickandPayStore
//
//  Created by iMac on 4/5/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var backToHomeButton: UIButton!
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide error label
        errorLabel.alpha = 0
        
        Utilities.styleTextField(mobileNumberTextField, placeHolderString: "mobile number")
        Utilities.styleTextField(emailTextField, placeHolderString: "email")
        Utilities.styleTextField(passwordTextField, placeHolderString: "password")
        Utilities.styleHollowButton(loginButton)
        
        mobileNumberTextField.becomeFirstResponder()
    }
    
    
    @IBAction func backToHomeButtonTapped(_ sender: Any) {
        PresenterManager.shared.show(vc: .home)
    }
    
}
