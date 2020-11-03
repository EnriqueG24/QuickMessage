//
//  LoginViewController.swift
//  QuickMessage
//
//  Created by Enrique Gongora on 10/29/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    // If there is an error we'll print present an alert to the user describing what the error is
                    let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    // otherwise we're safe to segue into the chatviewcontroller if the login was error free
                    self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
            }
        }
    }
}
