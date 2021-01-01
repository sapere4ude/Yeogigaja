//
//  LargeCardCollectionViewCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2021/01/01.
//  Copyright © 2021 sapere4ude. All rights reserved.
//

import UIKit

class LargeCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 3
        }
    }
    @IBOutlet var locationLabel: UILabel!
}
