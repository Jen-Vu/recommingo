
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
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
