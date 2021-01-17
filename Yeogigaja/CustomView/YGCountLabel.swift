//
//  YGCountLabel.swift
//  Yeogigaja
//
//  Created by 김진태 on 2021/01/12.
//  Copyright © 2021 sapere4ude. All rights reserved.
//

import UIKit

class YGCountLabel: UILabel {
    var labelTitle: String = "labelTitle"
    var count: Int {
        get {
            return _count
        }
        set {
            _count = newValue
            text = "\(labelTitle) \(_count)개"
        }
    }
    
    private var _count = 0
}
