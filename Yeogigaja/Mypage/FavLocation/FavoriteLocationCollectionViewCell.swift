//
//  FavoriteLocationCollectionViewCell.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/12/20.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class FavoriteLocationCollectionViewCell: UICollectionViewCell {
    
    var selectedItem: Int = 0
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override var isSelected: Bool{
        didSet {
            //did SEt 으로 바뀔 때 마다
            self.locationView.backgroundColor = isSelected ? UIColor.red : UIColor.systemGray5
            self.locationLabel.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
}


