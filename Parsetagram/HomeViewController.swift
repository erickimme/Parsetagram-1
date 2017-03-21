//
//  HomeViewController.swift
//  Parsetagram
//
//  Created by Ryuji Mano on 3/9/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var posts: [Post]?
    var images: [UIImage]?
    
    var user: PFUser?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getImages()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 475
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        let post = posts?[(posts?.count)! - indexPath.row - 1]
        
//        let user = post?["author"] as? PFUser
//        try! user?.fetchIfNeeded()
//        if let username = user?.username {
//            cell.usernameLabel.text = username
//        }
//        cell.captionLabel.text = post?["caption"] as? String
//        if let file = post?["media"] as? PFFile {
//            file.getDataInBackground(block: { (data: Data?, error: Error?) in
//                if (error != nil) {
//                    cell.postView.image = #imageLiteral(resourceName: "iconmonstr-picture-17-240")
//                }
//                else {
//                    cell.postView.image = UIImage(data: data!)
//                }
//            })
//        }
//
        
        cell.usernameLabel.text = post?.username
        cell.captionLabel.text = post?.caption
        cell.postView.image = post?.post
        cell.profileView.image = post?.profileImage
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTap(sender:)))
        cell.usernameLabel.isUserInteractionEnabled = true
        cell.profileView.isUserInteractionEnabled = true
        cell.usernameLabel.addGestureRecognizer(tapGestureRecognizer)
        cell.profileView.addGestureRecognizer(tapGestureRecognizer)
        cell.dateLabel.text = post?.date
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func getImages() {
        Post.getImages(for: nil, success: { (posts: [PFObject]) in
            var arr: [Post] = []
            for post in posts {
                arr.append(Post(post, self.tableView))
            }
            self.posts = arr
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
        }) { (error: Error) in
            let alert = UIAlertController(title: "An Error Occurred", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(action)
            self.show(alert, sender: nil)
        }
    }
    
    func onTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: location)
        self.user = posts?[(posts?.count)! - 1 - (indexPath?.row)!].user
        performSegue(withIdentifier: "profileSegue", sender: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ProfileViewController
        destination.user = self.user
    }
    

}
