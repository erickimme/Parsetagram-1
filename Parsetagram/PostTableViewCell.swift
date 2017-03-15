//
//  PostTableViewCell.swift
//  Parsetagram
//
//  Created by Ryuji Mano on 3/11/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
