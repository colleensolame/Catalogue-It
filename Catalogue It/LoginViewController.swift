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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        
        
        if (txtEmail.text?.isEmpty == true) || (txtPassword.text?.isEmpty == true) {
            let alert = UIAlertController(title: "Login Failed", message: "Please enter email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        /*} else if {*/
            
        } else {
            performSegue(withIdentifier: "collectionsSegue", sender: nil)
        }
        
        /*
            let databaseRef = Auth.auth().
            
            databaseRef.child("Users").observeSingleEventOfType(FIRDataEventType.Value, withBlock: { (snapshot) in
                
                if snapshot.hasChild(self.usernameTextField.text!){
                    
                    print("true rooms exist")
                    
                }else{
                    
                    print("false room doesn't exist")
                }
                
                
            })*/
        /*Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("We have an error: \(String(describing: error))")
                let alertController = UIAlertController(title: "Email not found", message: "Please register an account first", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                
            } else {
                print("We have sign in successfully")
            }
        }*/
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
    }
}

