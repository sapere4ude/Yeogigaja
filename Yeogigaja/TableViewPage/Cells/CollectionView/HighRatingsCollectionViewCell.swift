//
//  CardCollectionViewCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2021/01/01.
//  Copyright © 2021 sapere4ude. All rights reserved.
//

import UIKit
import Cosmos

class HighRatingsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.numberOfLines = 2
        }
    }
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 3
        }
    }
    
    @IBOutlet var starRatingView: CosmosView!
}
