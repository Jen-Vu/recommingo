//
//  CameraViewController.swift
//  Recommingo
//
//  Created by Graeme Renfrew on 17/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class CameraViewController: UIViewController {
    
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CameraViewController.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
        
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareButton_TouchUpInside(_ sender: Any) {
        ProgressHUD.show("Sharing...", interaction: false)
        
        if let profileImg = self.selectedImage, let imageData = profileImg.jpegData(compressionQuality: 0.1 ) {
            
            //storage data not to be tied to user information, so dont use uid
            let photoId = NSUUID().uuidString
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("posts").child(photoId)
            
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                
                //get the url where we just uploaded the photo to
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        ProgressHUD.showError(error!.localizedDescription)
                        return
                    }
                    let photoUrl = "\(String(describing: url))"
                    self.sendDataToDatabase(photoUrl: photoUrl)
                })
 
            })
        } else {
            ProgressHUD.showError("Please add a photo to your post")
        }
            
        }
    
 
    
        func sendDataToDatabase(photoUrl: String) {
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let postsReference = ref.child("posts")
            
            let newPostId = postsReference.childByAutoId().key
            let newPostReference = postsReference.child(newPostId!)
            
            //do something AFTER the upload process finishes
            newPostReference.setValue([ "photoUrl": photoUrl, "caption": captionTextView.text!]) { (error, ref) in
                //if the upload fails, we'll have an error object
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                ProgressHUD.showSuccess("Success")
                //reset the post view
                self.captionTextView.text = ""
                self.photo.image = UIImage(named: "placeholder-photo")
                
                //go back to the Home page
                self.tabBarController?.selectedIndex = 0  
            }
        }

}
    
extension CameraViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImage = image
                photo.image = image
            }
            dismiss(animated: true, completion: nil)
        }
}
