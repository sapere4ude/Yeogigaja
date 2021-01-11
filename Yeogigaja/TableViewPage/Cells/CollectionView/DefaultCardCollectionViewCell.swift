//
//  CardCollectionViewCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2021/01/01.
//  Copyright © 2021 sapere4ude. All rights reserved.
//

import UIKit

class DefaultCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 3
        }
    }
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 1
        }
    }
    @IBOutlet var locationLabel: UILabel! {
        didSet {
            locationLabel.numberOfLines = 2
        }
    }
}
