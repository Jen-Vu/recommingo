//
//  AuthService.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 18/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
        
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void) {
        print("method call AuthService.signIn()")
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            onSuccess()
            
        } )
    }
   
}
