//
//  SignUpViewController.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 16/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.tintColor = UIColor.white
        usernameTextField.textColor = UIColor.white
        usernameTextField.attributedPlaceholder =
            NSAttributedString(string: usernameTextField.placeholder!,
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor(white:1.0, alpha:0.6)])
        
        //Add a little line by creating a new layer, and adding a line to it
        let bottomLayerUsername = CALayer()
        bottomLayerUsername.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerUsername.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        usernameTextField.layer.addSublayer(bottomLayerUsername)
        
        
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
        
        //round the profile photo
        profileImage.layer.cornerRadius = 40
        profileImage.clipsToBounds = true
        //allow it to be tapped to go to image picker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
       profileImage.addGestureRecognizer(tapGesture)
       profileImage.isUserInteractionEnabled = true
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSelectProfileImageView() {
        print("todo tapped")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signUpBtn_TouchUpInside(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            // ...
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let usersReference = ref.child("users")
            let uid = authResult?.user.uid
            let newUserReference = usersReference.child(uid!)

            //store profile-like user data in the users node (different from authentication)
            newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!])
            print(" userDesc  \(newUserReference.description())")
            guard let user = authResult?.user else { return }
            print(user)
        }
        
        
        //FirebaseAuth.Auth.auth().createUser(withEmail: "user1@gmail.com", password: "123456",  completion: {
            //(user: User?, error: Error?) in
            //if error != nil {
             //   print(error?.localizedDescription)
             //   return
           // }
           // print(user)
        //})
        
    }
    
}

// allow for the user to select a profile pic from camera roll while signing up
extension SignUpViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("did finish?")
        dismiss(animated: true, completion: nil)
    }
}
