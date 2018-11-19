//
//  Post.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 18/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
class Post {
    var caption: String?
    var photoUrl: String?
    var uid: String?
    
    
}

extension Post {

    static func transformPost(dict: [String: Any]) -> Post {
        let post = Post()
        post.caption = dict["caption"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        post.uid = dict["uid"] as? String
        return post
    }
    
    
}
