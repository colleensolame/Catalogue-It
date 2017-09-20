//
//  LoginViewController.swift
//  Catalogue It
//
//  Created by Colleen Ng on 9/19/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        if (txtEmail.text?.isEmpty == true) || (txtPassword.text?.isEmpty == true) {
            //Validation : Check if all fields are entered
            
            let alert = UIAlertController(title: "Login Failed", message: "Please enter email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            // Sign in, check if email is registered in database
            Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
                
                if error != nil {
                    // Email is not found in database or email and password do not match
                    
                    print("We have an error: \(String(describing: error))")
                    let alertController = UIAlertController(title: "Login Failed", message: "Invalid Email/Password", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                } else {
                    
                    print("We have sign in successfully")
                    self.performSegue(withIdentifier: "collectionsSegue", sender: nil)
                }
            }
            
        }
        
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
    }
}

