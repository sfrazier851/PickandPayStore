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
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // to store the current active textfield
    var activeTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style textfields, button and error label
        setupUI()
        
        mobileNumberTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        mobileNumberTextField.text = "8888888888"
        usernameTextField.text = "new_user"
        emailTextField.text = "newuser@gmail.com"
        passwordTextField.text = "Password!"
        confirmPasswordTextField.text = "Password!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // call the 'keyboardWillShow' function when the view controller receives notification that the keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controller receives notification that the keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        mobileNumberTextField.becomeFirstResponder()
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
        errorLabel.textAlignment = .center
        
        Utilities.styleTextField(mobileNumberTextField, placeHolderString: "mobile number")
        Utilities.styleTextField(usernameTextField, placeHolderString: "username")
        Utilities.styleTextField(emailTextField, placeHolderString: "email")
        Utilities.styleTextField(passwordTextField, placeHolderString: "password")
        Utilities.styleTextField(confirmPasswordTextField, placeHolderString: "confirm password")
        Utilities.styleHollowButton(registerButton)
        
        hideKeyboardWhenTappedAround()
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    private func validateFields() -> String? {

        // Check that username, email, password and confirm password fields are filled in
        if  usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

            return "Please make sure all fields are filled in."
        }

        //Check if the email is a valid email
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilities.isValidEmail(email: cleanedEmail) == false {
            // email isn't proper format
            return "Please make sure your email is formatted correctly."
        }

        // Check if the password is secure
        let password = passwordTextField.text! //.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilities.isValidPassword(password) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters and contains a special character."
        }

        // Check that password and confirm password matches
        let confirmPassword = confirmPasswordTextField.text! //.trimmingCharacters(in: .whitespacesAndNewlines)

        if password != confirmPassword {
            return "Passwords don't match. Please try again."
        }

        return nil
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        // Clear the error label
        errorLabel.alpha = 0

        // Validate the fields
        let error = validateFields()

        if error != nil {

            // There's something wrong with the fields, show error message
            showError(error!)
        } else {
            let phonenumber = mobileNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // check if user with email already exists
            if User.getByEmail(email: email)!.count == 0 {
                // user does not already exist
                // Create the user
                User.create(username: username, email: email, password: password, phoneNumber: phonenumber)
                UserSessionManager.shared.setLoggedInUser(user: User.getNewlyCreated()![0])
                PresenterManager.shared.show(vc: .shop)
            }
            else {
                // user email already exists
                showError("That user with email: \(email) already exists.")
            }
        }
    }
    
    @IBAction func backToHomeButtonTapped(_ sender: Any) {
        PresenterManager.shared.show(vc: .home)
    }
    
    private func showError(_ message:String) {

        errorLabel.text = message
        errorLabel.alpha = 1
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
