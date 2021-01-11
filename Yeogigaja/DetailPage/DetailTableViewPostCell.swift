//
//  DetailTextTableViewCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/11/02.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import Cosmos

class DetailTableViewPostCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var userProfileImageView: UIImageView! {
        didSet {
            userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2.0
            userProfileImageView.clipsToBounds = true
            userProfileImageView.backgroundColor = .lightGray
        }
    }
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starRatingView: CosmosView!
}
