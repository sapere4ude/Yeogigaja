//
//  CardCollectionViewCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2021/01/01.
//  Copyright © 2021 sapere4ude. All rights reserved.
//

import UIKit
import Cosmos

class NearestPinnedCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 8.0
            imageView.clipsToBounds = true
        }
    }
    @IBOutlet var locationLabel: UILabel! {
        didSet {
            locationLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet var starRatingView: CosmosView!
}
