//
//  ProfileViewController.swift
//  Parsetagram
//
//  Created by Ryuji Mano on 3/9/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
