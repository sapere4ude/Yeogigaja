//
//  HorizontalCollectionImageViewCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/12/07.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class HorizontalCollectionImageViewCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
