//
//  CollectionsViewController.swift
//  Catalogue It
//
//  Created by Colleen Ng on 9/20/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var collections: [String] = []
    
    @IBOutlet weak var collectionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionsTableView.dataSource = self
        collectionsTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = collections[indexPath.row]
        
        return cell
        
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "Create New Collection", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Create", style: .default) { (_) in
            if alertController.textFields?[0].text != "" {
                self.collections.append((alertController.textFields?[0].text)!)
                self.collectionsTableView.reloadData()
            } else {
                self.collections.append("(empty)")
                self.collectionsTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "New Collection"
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            /*let collection = collections[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(sound)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                try sounds = context.fetch(Sound.fetchRequest())
                collectionsTableView.reloadData()
            } catch {}*/
            collections.remove(at: indexPath.row)
            collectionsTableView.reloadData()
        }
    }

}










