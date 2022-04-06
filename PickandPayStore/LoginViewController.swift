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
    
    // to store the current active textfield
    var activeTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style the textfields, button and error label
        setupUI()
        
        mobileNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
        
        Utilities.styleTextField(mobileNumberTextField, placeHolderString: "mobile number")
        Utilities.styleTextField(emailTextField, placeHolderString: "email")
        Utilities.styleTextField(passwordTextField, placeHolderString: "password")
        Utilities.styleHollowButton(loginButton)
        
        hideKeyboardWhenTappedAround()
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    private func validateFields() -> String? {
        // Check that email and password fields are filled in
        if  (mobileNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" &&
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

            return "Please make sure email (or phone #) and password fields are filled in."
        }

        //Check if the email is a valid email
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilities.isValidEmail(email: cleanedEmail) == false {
            // email isn't proper format
            return "Please make sure your email is formatted correctly."
        }

        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilities.isValidPassword(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters and contains a special character."
        }

        return nil

    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // Clear the error label
        errorLabel.alpha = 0
        errorLabel.textAlignment = .center

        // Validate the fields
        let error = validateFields()

        if error != nil {
            // There's something wrong with the fields, show error message
            showError(error!)
        } else {
            // Create cleaned versions of the text field
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            var userToLogin: [User]? = User.getByEmail(email: email)
            
            if let userToLoginValue = userToLogin {
                userToLogin = userToLoginValue
                if email == "" || password == "" {
                    showError("Pleae make sure both fields are filled in.")
                } else if userToLogin?.count == 0 {
                    showError("User with email: \(email), doesn't exist.")
                } else {
                    if userToLogin?[0].password == password {
                        PresenterManager.shared.show(vc: .home)
                    } else {
                        showError("Incorrect credentials, please try again.")
                    }
                }
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
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
