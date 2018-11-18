//
//  AuthService.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 18/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class AuthService {
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        print("method call AuthService.signIn()")
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        } )
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        print("method call AuthService.signUp()")
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            // ...
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            let uid = authResult?.user.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("profile_image").child(uid!)
            
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print("failed to get url from meta data", error!)
                        return
                    }
                    let profileImageUrl = "\(String(describing: url))"
                    self.setUserInformation(profileImageUrl: profileImageUrl, username: username, email: email, uid: uid!, onSuccess: onSuccess)
                })
            }
            )
            
        }
    }
    static func setUserInformation(profileImageUrl: String, username: String, email: String, uid: String, onSuccess: @escaping () -> Void ) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username":  username, "email":  email, "profileImageUrl": profileImageUrl])
        onSuccess()
    }
}
