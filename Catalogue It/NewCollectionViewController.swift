//
//  NewCollectionViewController.swift
//  Catalogue It - Personal Collections
//
//  Created by Colleen Ng on 9/21/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class NewCollectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var collections: [Collection] = []
    var users: [User] = []
    var collectionTitle = ""
    var collectionSubtitle = ""
    var imageURL = ""

    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtSubtitle: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        addButton.isEnabled = false
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        collectionImageView.image = image
        collectionImageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func btnPhotos(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        imagePicker.allowsEditing = false
    }
    
    @IBAction func btnCamera(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        imagePicker.allowsEditing = false
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        
        addButton.isEnabled = false
        
        collectionTitle = txtTitle.text!
        collectionSubtitle = txtSubtitle.text!
        
        let imagesFolder = Storage.storage().reference().child("collectionImage")
        let imageData = UIImageJPEGRepresentation(collectionImageView.image!, 0.1)!
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil, completion: {(metadata, error) in
            
            print("We tried to upload!")
            
            if error != nil {
                
                print("We had an error: \(String(describing: error))")
                
            } else {
                
                print(metadata?.downloadURL() as Any)
                
                self.imageURL = (metadata?.downloadURL()!.absoluteString)!

                let collection = ["title": self.collectionTitle, "subtitle": self.collectionSubtitle, "collectionImageURL": self.imageURL]
                
                Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("Full Name").child(Auth.auth().currentUser!.displayName!).child("collections").childByAutoId().setValue(collection)
                
                self.navigationController!.popViewController(animated: true)
                self.addButton.isEnabled = true
            }
        })

    }
    
    
    
    
    
    
    
    
    
    
    
}
