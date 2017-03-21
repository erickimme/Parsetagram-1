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
    
    var user: PFUser!
    
    var photos: [UIImage] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let _ = tabBarController {
            user = PFUser.current()
        }
        
        usernameLabel.text = user.username
        if let file = user["photo"] as? PFFile {
            file.getDataInBackground(block: { (data: Data?, error: Error?) in
                if error == nil {
                    self.profileView.image = UIImage(data: data!)!
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTap))
        profileView.isUserInteractionEnabled = true
        profileView.addGestureRecognizer(gestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        
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
        
        profileView.image = edited
        
        user["photo"] = Post.getPFFileFromImage(image: edited)
        try! user.save()
        
        dismiss(animated: true, completion: nil)
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
