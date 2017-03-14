//
//  LoginViewController.swift
//  Parsetagram
//
//  Created by Ryuji Mano on 3/7/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                let alert = UIAlertController(title: "An Error Occurred", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.show(alert, sender: nil)
            }
        }
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                let alert = UIAlertController(title: "Sign Up Successful", message: "You have been successfully signed up. Please login to continue.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(action)
                
                MBProgressHUD.hide(for: self.view, animated: true)
                
                self.show(alert, sender: nil)
            }
            else {
                let alert = UIAlertController(title: "An Error Occurred", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(action)
                
                MBProgressHUD.hide(for: self.view, animated: true)
                
                self.show(alert, sender: nil)
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
    }
    */

}
