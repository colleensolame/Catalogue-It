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
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var lblSuccess: UILabel!
    @IBOutlet weak var buttonSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblSuccess.isHidden = true
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        if (txtUsername.text?.isEmpty == true) || (txtEmail.text?.isEmpty == true) || (txtPassword.text?.isEmpty == true) || (txtConfirmPassword.text?.isEmpty == true) {
            
            lblSuccess.isHidden = true
            let alert = UIAlertController(title: "Sign Up Failed", message: "Please enter all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if txtPassword.text != txtConfirmPassword.text {
            
            lblSuccess.isHidden = true
            let alert = UIAlertController(title: "Sign Up Failed", message: "Your passwords do not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if (txtPassword.text?.characters.count)! < 6 {
            
            lblSuccess.isHidden = true
            let alert = UIAlertController(title: "Sign Up Failed", message: "Password has to be more than 6 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            buttonSignUp.isEnabled = false
            
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (user, error) in
                if error != nil {
                    
                    self.lblSuccess.isHidden = true
                    let alert = UIAlertController(title: "Sign Up Failed", message: "The email address is already in use", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.buttonSignUp.isEnabled = true
                    
                } else {
                    
                    let changeRequest = user!.createProfileChangeRequest()
                    changeRequest.displayName = self.txtUsername.text
                    changeRequest.commitChanges(completion: { (error) in
                        if error != nil {
                            print("We have another error: \(String(describing: error))")
                        } else {
                            
                            Database.database().reference().child("users").child(user!.uid).child("Full Name").child((user!.displayName)!).child("email").setValue(user!.email!)
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
