//
//  Post.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 18/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
class Post {
    var caption: String
    var photoUrl: String
    
    init(captionText: String, photoUrlString: String) {
      caption = captionText
      photoUrl  = photoUrlString
    }
}
