//
//  DetailTableViewCommentCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2021/01/14.
//  Copyright © 2021 sapere4ude. All rights reserved.
//

import UIKit

class DetailTableViewCommentCell: UITableViewCell {
    @IBOutlet var commentView: UIView! {
        didSet {
            commentView.layer.cornerRadius = 16
            commentView.clipsToBounds = true
        }
    }
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = userImageView.frame.width / 2.0
            userImageView.clipsToBounds = true
        }
    }
}
