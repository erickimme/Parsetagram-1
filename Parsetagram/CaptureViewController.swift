//
//  CaptureViewController.swift
//  Parsetagram
//
//  Created by Ryuji Mano on 3/9/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var postView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var libraryLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        libraryLabel.isHidden = false
        libraryButton.isHidden = false
        libraryButton.isUserInteractionEnabled = true
        cameraLabel.isHidden = false
        cameraButton.isHidden = false
        cameraButton.isUserInteractionEnabled = true
        
        postView.isHidden = true
        captionField.isHidden = true
        captionField.isUserInteractionEnabled = false
        postButton.isHidden = true
        postButton.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func libraryTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        show(imagePicker, sender: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        
        show(imagePicker, sender: nil)
    }
    
    @IBAction func postTapped(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Post.postUserImage(image: resize(image: postView.image!, newSize: CGSize(width: 300, height: 300)), withCaption: captionField.text ?? "") { (success: Bool, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if success {
                self.tabBarController?.selectedIndex = 0
            }
            else {
                let alert = UIAlertController(title: "An Error Occurred", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(action)
                self.show(alert, sender: nil)
            }
            
            self.libraryLabel.isHidden = false
            self.libraryButton.isHidden = false
            self.libraryButton.isUserInteractionEnabled = true
            self.cameraLabel.isHidden = false
            self.cameraButton.isHidden = false
            self.cameraButton.isUserInteractionEnabled = true
            
            self.postView.isHidden = true
            self.captionField.isHidden = true
            self.captionField.isUserInteractionEnabled = false
            self.postButton.isHidden = true
            self.postButton.isUserInteractionEnabled = false
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let original = info[UIImagePickerControllerOriginalImage] as! UIImage!
        let edited = info[UIImagePickerControllerEditedImage] as! UIImage!
        
        postView.image = edited
        
        
        libraryLabel.isHidden = true
        libraryButton.isHidden = true
        libraryButton.isUserInteractionEnabled = false
        cameraLabel.isHidden = true
        cameraButton.isHidden = true
        cameraButton.isUserInteractionEnabled = false
        
        postView.isHidden = false
        captionField.isHidden = false
        captionField.isUserInteractionEnabled = true
        postButton.isHidden = false
        postButton.isUserInteractionEnabled = true
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
