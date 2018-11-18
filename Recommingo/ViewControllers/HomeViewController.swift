
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
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 500
        tableView.dataSource = self //this calls the extension below
        loadPosts()
    }
    
    func loadPosts() {
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                    //create post instance from dictionary key:value pair
                    let newPost = Post.transformPost(dict: dict)
                
                //append the latest snapshot into an array of posts
                self.posts.append(newPost)
                self.tableView.reloadData()
            }
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
     return posts.count
      //return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell()
        //re-usable cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! HomeTableViewCell
        
        cell.profileImageView.image = UIImage(named: "photo1")
        cell.nameLabel.text = "Steve-o"
        cell.postImageView.image = UIImage(named:"photo2")
        cell.captionLabel.text = "Oh this is the good stuff"
 
        
        return cell
    }
    
}
