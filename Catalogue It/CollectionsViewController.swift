//
//  CollectionsViewController.swift
//  Catalogue It
//
//  Created by Colleen Ng on 9/20/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class CollectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var collections: [Collection] = []
    var frameView: UIView!
    
    @IBOutlet weak var collectionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionsTableView.dataSource = self
        collectionsTableView.delegate = self
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("collections").observe(DataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            let collection = Collection()
            let snapshotValue = snapshot.value as? NSDictionary
            collection.collectionImageURL = snapshotValue!["collectionImageURL"] as! String
            collection.title = snapshotValue!["title"] as! String
            collection.subTitle = snapshotValue!["subtitle"] as! String
            
            self.collections.append(collection)
            self.collectionsTableView.reloadData()
            
            
        })

        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                               reuseIdentifier: nil)
        let collection = collections[indexPath.row]
        
        cell.textLabel?.text = collection.title
        cell.detailTextLabel?.text = collection.subTitle
        
        return cell
        
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "itemsSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let collection = collections[indexPath.row]
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//            context.delete(sound)
//            (UIApplication.shared.delegate as! AppDelegate).saveContext()
//            do {
//                try sounds = context.fetch(Sound.fetchRequest())
//                collectionsTableView.reloadData()
//            } catch {}
            collections.remove(at: indexPath.row)
            collectionsTableView.reloadData()
        }
    }

}










