//
//  RegisterViewController.swift
//  QuickMessage
//
//  Created by Enrique Gongora on 10/29/20.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    // If there is an error we'll print present an alert to the user describing what the error is
                    let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    // otherwise if there were no errors upon registering, we can safely proceed to our chatviewcontroller. 
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
    }
}
