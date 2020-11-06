//
//  CollectionViewCell.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/06.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
