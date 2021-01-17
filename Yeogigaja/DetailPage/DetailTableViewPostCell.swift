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
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.lineBreakMode = .byCharWrapping
        }
    }
    @IBOutlet var starRatingView: CosmosView!
    @IBOutlet var tagListView: YGTagListView!
    @IBOutlet var favoriteCountLabel: YGCountLabel! {
        didSet {
            favoriteCountLabel.labelTitle = "좋아요"
            favoriteCountLabel.count = 0
        }
    }
    @IBOutlet var pinnedCountLabel: YGCountLabel! {
        didSet {
            pinnedCountLabel.labelTitle = "핀찍기"
            pinnedCountLabel.count = 0
        }
    }
    @IBOutlet var commentCountLabel: YGCountLabel! {
        didSet {
            commentCountLabel.labelTitle = "댓글"
            commentCountLabel.count = 0
        }
    }
    @IBOutlet var favoriteButton: DetailCountButton! {
        didSet {
            favoriteButton.iconImage = UIImage(named: "like")
            favoriteButton.highlightedIconImage = UIImage(named: "likeFill")
            favoriteButton.text = "좋아요"
        }
    }
    @IBOutlet var pinButton: DetailCountButton! {
        didSet {
            pinButton.iconImage = UIImage(named: "pin")
            pinButton.text = "핀찍기"
        }
    }
    @IBOutlet var commentButton: DetailCountButton! {
        didSet {
            commentButton.iconImage = UIImage(named: "comment")
            commentButton.text = "댓글"
        }
    }
    @IBOutlet var dateLabel: UILabel!
}
