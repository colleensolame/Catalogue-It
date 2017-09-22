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

class NewCollectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    
    
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
    @IBOutlet weak var photosButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        addButton.isEnabled = false
        imagePicker.delegate = self
        
        view.addSubview(scrollView)
        let sizes = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize = sizes
        
//        let sizes
//        let sizing = CGSize(width: self.view.frame.width, height: (self.view.frame.height + 100))
//        scrollView.contentSize = sizing
    }
    
    

    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        txtTitle.resignFirstResponder()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: .UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
        super.viewWillDisappear(animated)
    }
    
    func keyboardWasShown(_ notification: Notification) {
        let info = notification.userInfo
        let keyboardSize: CGSize? = (info?[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue?.size
        let buttonOrigin: CGPoint = addButton.frame.origin
        let buttonHeight: CGFloat = addButton.frame.size.height
        var visibleRect: CGRect = view.frame
        visibleRect.size.height -= (keyboardSize?.height)!
        if !visibleRect.contains(buttonOrigin) {
            let scrollPoint = CGPoint(x: 0.0, y: buttonOrigin.y - visibleRect.size.height + buttonHeight)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    func keyboardWillBeHidden(_ notification: Notification) {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
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
                
                Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("collections").childByAutoId().setValue(collection)
                
                self.navigationController!.popViewController(animated: true)
                self.addButton.isEnabled = true
            }
        })

    }
    
    
    
    
    
    
    
    
    
    
    
}
