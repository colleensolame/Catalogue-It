//
//  SignUpViewController.swift
//  Catalogue It
//
//  Created by Colleen Ng on 9/20/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    // Range for text input allowed. Only characters
    let set = NSCharacterSet.letters.inverted
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var lblSuccess: UILabel!
    @IBOutlet weak var buttonSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblSuccess.isHidden = true   // Hide success button until account has been successfully created
        
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: nil)    // Segue back to login screen
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        if (txtFullName.text?.isEmpty == true) || (txtEmail.text?.isEmpty == true) || (txtPassword.text?.isEmpty == true) || (txtConfirmPassword.text?.isEmpty == true) {
            // Validation: Check if all fields are entered
            
            lblSuccess.isHidden = true
            let alert = UIAlertController(title: "Sign Up Failed", message: "Please enter all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if txtFullName.text!.rangeOfCharacter(from: set) != nil {
            // Validation: Check if Full Name contains numbers or special characters
            
            lblSuccess.isHidden = true
            let alert = UIAlertController(title: "Sign Up Failed", message: "Full Name cannot contain numbers or space or special characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if txtPassword.text != txtConfirmPassword.text {
            // Validation: Check if password and confirm password matches
            
            lblSuccess.isHidden = true
            let alert = UIAlertController(title: "Sign Up Failed", message: "Your passwords do not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if (txtPassword.text?.characters.count)! < 6 {
            // Validation: Check if password is more than 6 characters
            
            lblSuccess.isHidden = true
            let alert = UIAlertController(title: "Sign Up Failed", message: "Password has to be more than 6 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            buttonSignUp.isEnabled = false    // Disables sign up button until sign up process is complete
            
            // Create new user in Firebase
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (user, error) in
                
                // Error in email formatting or email already in database
                if error != nil {
                    
                    print(error as Any)
                    self.lblSuccess.isHidden = true
                    let alert = UIAlertController(title: "Invalid Email", message: "The email given is wrong or is already in use", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.buttonSignUp.isEnabled = true
                    
                } else {
                    
                    // Adding user's Full Name to the database
                    let changeRequest = user!.createProfileChangeRequest()
                    changeRequest.displayName = self.txtFullName.text
                    changeRequest.commitChanges(completion: { (error) in
                        
                        if error != nil {
                            print("We have another error: \(String(describing: error))")
                        } else {
                            
                            // Adding user information to database
                            let users = ["name": user!.displayName!, "email": user!.email!]
                                
                            Database.database().reference().child("users").child(user!.uid).setValue(users)
                            self.buttonSignUp.isEnabled = true
                            self.lblSuccess.isHidden = false
                            print("Success!!")
                        }
                    }
                    )}
                
            })
        }
    }
}
