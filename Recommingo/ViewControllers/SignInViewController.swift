//
//  SignInViewController.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 16/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit
import FirebaseAuth
 

class SignInViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder =
            NSAttributedString(string: emailTextField.placeholder!,
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor(white:1.0, alpha:0.6)])
        
        //Add a little line by creating a new layer, and adding a line to it
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayerEmail)
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder =
            NSAttributedString(string: passwordTextField.placeholder!,
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor(white:1.0, alpha:0.6)])
        
        //Add a little line by creating a new layer, and adding a line to it
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        signInButton.isEnabled = false
        handleTextField()
        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // do stuff only after we are sure the viewDidAppear has loaded
        print("[DEBUG***]in override func viewDidAppear")
        super.viewDidAppear(animated)
        //check if we already have this user in cache/credentials
        if Auth.auth().currentUser != nil {
            print("current user:   \(String(describing: Auth.auth().currentUser))")
            self.performSegue(withIdentifier: "signInToTabbarVC", sender: nil)
        }
        
    }
    
    @objc func handleTextField(){
        emailTextField.addTarget(self, action:  #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action:  #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        
    }
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signInButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            signInButton.isEnabled = false
            return
        }
        signInButton.isEnabled = true
        signInButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
    @IBAction func signInButton_TouchUpInside(_ sender: Any) {
       view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
             ProgressHUD.showSuccess("Success")
            self.performSegue(withIdentifier: "signInToTabbarVC", sender: nil)
        }, onError: {  error in
            ProgressHUD.showError(error!)
        })
        
    }
    
}
