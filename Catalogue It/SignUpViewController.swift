//
//  SignUpViewController.swift
//  Catalogue It
//
//  Created by Colleen Ng on 9/20/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnBack(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    

}
