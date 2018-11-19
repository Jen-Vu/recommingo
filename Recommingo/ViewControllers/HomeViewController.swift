
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
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    //cache of current posts and users for the home view
    var posts = [Post]()
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //because we spent time setting up all the contraints, we can use automaticDimension to all
        //the table rows to expand to contain all the content we want - e.g. a really long comment
        tableView.estimatedRowHeight = 521
        tableView.rowHeight = UITableView.automaticDimension
        
        //Use this value until we put AutoLayout in place, otherwise the rows are 44 px
        //tableView.rowHeight = 500
        tableView.dataSource = self //this calls the extension below
        loadPosts()
    }
    
    func loadPosts() {
            activityIndicatorView.startAnimating()
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                //create post instance from dictionary key:value pair
                let newPost = Post.transformPost(dict: dict)
                
                //get the user for the posts
                //self.fetchUser(uid: newPost.uid!)
                self.fetchUser(uid: newPost.uid!, completed: {
                    self.activityIndicatorView.stopAnimating()
                    print("DEBUG: newPost uid:" + "\(String(describing: newPost.uid))")
                    self.posts.append(newPost)
                    
                    self.tableView.reloadData()
                })
                print("DEBUG: newPost:" + "\(newPost)")
              
            }
        }
    }
    
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        
        print("DEBUG UID: " + uid)
        //get the user info for whoever posted the loadPost post
            Database.database().reference().child("users").child("zPF9bMoyQoaOCiftiXq51gHzrrM2").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: Any]{
                    print("DEBUG xxx")
                    let user = User.transformUser(dict: dict)
                    self.users.append(user)
                    completed()
                }
            })
    
     
    }
        
        @IBAction func logout_TouchUpInside(_ sender: Any) {
            do {
                try Auth.auth().signOut()
                let storyboard:UIViewController = UIStoryboard(name:"Start", bundle:nil).instantiateViewController(withIdentifier: "SignInViewController") as UIViewController
                self.present(storyboard, animated: true, completion: nil)
                
                //show the profile image when we've logged out
                
            } catch let logoutError {
                print(logoutError)
            }
            
            
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
            let post = posts[indexPath.row]
            let user = users[indexPath.row] //these row values will be the same because we populate both arrays simultenously
            
            cell.post = post //check out the HomeTableViewCell class to see that since 'post' is an instance variable, we can now use didSet to call all required methods
            cell.user = user
            return cell
        }
        
}
