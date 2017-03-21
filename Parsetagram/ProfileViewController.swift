//
//  ProfileViewController.swift
//  Parsetagram
//
//  Created by Ryuji Mano on 3/9/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var user: PFUser!
    
    var photos: [UIImage] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        profileView.layer.cornerRadius = profileView.frame.width / 2
        profileView.clipsToBounds = true
        
        if tabBarController?.selectedIndex == 2 {
            user = PFUser.current()
        }
        
        usernameLabel.text = user.username
        if let file = user.value(forKey: "photo") as? PFFile {
            file.getDataInBackground(block: { (data: Data?, error: Error?) in
                if error == nil {
                    self.profileView.image = UIImage(data: data!)!
                }
            })
        }
        
        Post.getImages(for: user, success: { (posts: [PFObject]) in
            self.photos = []
            for post in posts {
                if let file = post["media"] as? PFFile {
                    self.getPost(file, self.collectionView)
                }
            }
            self.collectionView.reloadData()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 3
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTap))
        profileView.isUserInteractionEnabled = true
        profileView.addGestureRecognizer(gestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.photoView.image = photos[indexPath.row]
        
        return cell
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if error != nil {
                let alert = UIAlertController(title: "An Error Occurred", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(action)
                self.show(alert, sender: nil)
            }
            else {
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            }
        }
    }
    
    func onTap() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        show(imagePicker, sender: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        let original = info[UIImagePickerControllerOriginalImage] as! UIImage!
        let edited = info[UIImagePickerControllerEditedImage] as! UIImage!
        
        profileView.image = resize(image: edited!, newSize: CGSize(width: 100, height: 100))
        
        user.setObject(Post.getPFFileFromImage(image: resize(image: edited!, newSize: CGSize(width: 100, height: 100)))!, forKey: "photo")
        user.saveInBackground()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = .scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func getPost(_ file: PFFile, _ collectionView: UICollectionView) {
        file.getDataInBackground(block: { (data: Data?, error: Error?) in
            if error == nil {
                self.photos.append(UIImage(data: data!)!)
                collectionView.reloadData()
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
