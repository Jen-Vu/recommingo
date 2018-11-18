
//
//  HomeViewController.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 17/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self //this calls the extension below
        
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
