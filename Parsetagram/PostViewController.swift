//
//  PostViewController.swift
//  Parsetagram
//
//  Created by Ryuji Mano on 12/9/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }

    var post: Post!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 475
    }

    @objc func onTap(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "profileSegue", sender: post.user)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProfileViewController {
            if let sender = sender as? PFUser {
                destination.user = sender
            }
        }
    }

}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell

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

        cell.selectionStyle = .none
        
        return cell
    }
}
