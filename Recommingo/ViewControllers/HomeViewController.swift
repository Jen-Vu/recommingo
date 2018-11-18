
//
//  HomeViewController.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 17/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self //this calls the extension below
        loadPosts()
        
    }
    
    func loadPosts() {
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
            print(snapshot.value)
        }
    }
    
    @IBAction func logout_TouchUpInside(_ sender: Any) {
         do {
                try Auth.auth().signOut()
            } catch let logoutError {
                print(logoutError)
                }
        let storyboard:UIViewController = UIStoryboard(name:"Start", bundle:nil).instantiateViewController(withIdentifier: "SignInViewController") as UIViewController
        self.present(storyboard, animated: true, completion: nil)
 
    }
    
   
    

}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell()
        //re-usable cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        //alternate
        cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = .red
        return cell
    }
    
}
