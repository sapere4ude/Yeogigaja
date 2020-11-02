//
//  DetailHeaderViewController.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/11/02.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton! {
        didSet {
            checkButton.layer.cornerRadius = checkButton.bounds.height / 2.0
        }
    }
    
}
