//
//  User.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 19/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
class User {
    var email: String?
    var profileImageUrl: String?
    var username: String?
    
}

extension User {
    static func transformUser(dict: [String: Any]) -> User {
        let user = User()
        user.email = dict["email"] as? String
        user.profileImageUrl = dict["profileImageUrl"] as? String
        user.username = dict["username"] as? String
        return user
    }
}
