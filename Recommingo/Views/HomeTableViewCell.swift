//
//  HomeTableViewCell.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 18/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var likeCountButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    
    //post is an instance variable of the cell, so we can easily access this
    var post: Post? {
        didSet {
            updateView()
        }
    }
    
    var user: User? {
        didSet {
            setupUserInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.text = "" //so we dn't incorrectly display the 'Label' string while waiting for loading
        captionLabel.text = ""
        
    }
    
    //get ready to repopulate the cell
    override func prepareForReuse() {
        super.prepareForReuse()
        print("DEBUG: prepareforReuse")
        profileImageView.image = UIImage(named: "placeholderImg")
    }
    
    //feed data from a post into a cell
    func updateView() {
        self.captionLabel.text = post?.caption
        //hold the photoUrl - do optional chaining as long as we're sure there's a URL...
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            self.postImageView.sd_setImage(with: photoUrl)
        }
        setupUserInfo()
        
    }
    
    func setupUserInfo() {
        //if let uid = post?.uid {
        //    Database.database().reference().child("users").child(uid).observeSingleEvent(of: DataEventType.value) { (snapshot: DataSnapshot) in
          //      if let dict = snapshot.value as? [String: Any]{
          //          let user = User.transformUser(dict: dict)
          //          self.nameLabel.text = user.username
          //          if let photoUrlString = user.profileImageUrl {
          //              let photoUrl = URL(string: photoUrlString)
           //             self.profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named:"placeholderImg"))
            //        }
            //    }
           // }
       // }
        nameLabel.text = user?.username
        if let photoUrlString = user?.profileImageUrl {
                       let photoUrl = URL(string: photoUrlString)
                       self.profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named:"placeholderImg"))
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
