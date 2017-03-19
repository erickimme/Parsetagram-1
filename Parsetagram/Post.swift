//
//  Post.swift
//  Parsetagram
//
//  Created by Ryuji Mano on 3/16/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    var username: String = ""
    var post: UIImage = #imageLiteral(resourceName: "iconmonstr-picture-17-240")
    var caption: String = ""
    var likesCount: Int = 0
    var commentsCount: Int = 0
    
    init(_ post: PFObject) {
        super.init()
        self.post = #imageLiteral(resourceName: "iconmonstr-picture-17-240")
        let user = post["author"] as? PFUser
        if let user = user {
            try! user.fetchIfNeeded()
            self.username = user.username!
        }
        self.caption = post["caption"] as? String ?? ""
        self.likesCount = post["likesCount"] as? Int ?? 0
        self.commentsCount = post["commentsCount"] as? Int ?? 0
        if let file = post["media"] as? PFFile {
            getPost(file)
        }
        
    }
    
    func getPost(_ file: PFFile) {
        file.getDataInBackground(block: { (data: Data?, error: Error?) in
            if error == nil {
                self.post = UIImage(data: data!)!
            }
        })
    }
    
    /**
     * Other methods
     */
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    class func getImages(success: @escaping ([PFObject]) -> (), failure: @escaping (Error) -> ()) {
        let query = PFQuery(className: "Post")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if error != nil {
                failure(error!)
            }
            else {
                success(posts!)
            }
        }
    }
}
