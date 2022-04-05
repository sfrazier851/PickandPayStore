//
//  RegisterViewController.swift
//  PickandPayStore
//
//  Created by iMac on 4/5/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var backToHomeButton: UIButton!
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // to store the current active textfield
    var activeTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the 'keyboardWillShow' function when the view controller receives notification that the keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controller receives notification that the keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        // style textfields, button and error label
        setupUI()
        
        mobileNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available
            return
        }
        
        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            // if the bottom of the textfield is below the top of the keyboard, move up
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            // amount to move the view up
            let moveUpDistance = activeTextField!.convert(activeTextField!.bounds, to: self.view).maxY - (self.view.frame.height - keyboardSize.height)
            
            // move the root view up by the distance of keyboard height
            self.view.frame.origin.y = 0 - moveUpDistance
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
    private func setupUI() {
        // hide error label
        errorLabel.alpha = 0
        
        Utilities.styleTextField(mobileNumberTextField, placeHolderString: "mobile number")
        Utilities.styleTextField(emailTextField, placeHolderString: "email")
        Utilities.styleTextField(passwordTextField, placeHolderString: "password")
        Utilities.styleTextField(confirmPasswordTextField, placeHolderString: "confirm password")
        Utilities.styleHollowButton(registerButton)
        
        mobileNumberTextField.becomeFirstResponder()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backToHomeButtonTapped(_ sender: Any) {
        PresenterManager.shared.show(vc: .home)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    // when user selects a textfield, this method will be called
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // set the activeTextField to the selected textfield
        self.activeTextField = textField
    }
    
    // when user clicks 'done' or dismiss keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}
