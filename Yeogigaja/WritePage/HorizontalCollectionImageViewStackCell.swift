//
//  HorizontalCollectionImageViewButtonCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/12/07.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class HorizontalCollectionImageViewStackCell: HorizontalCollectionImageViewCell {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var countLabel: UILabel!

    func setImageCount(count: Int, maxCount: Int) {
        let countLabelString = "\(count)/\(maxCount)"
        let countLabelMutableString = NSMutableAttributedString(string: countLabelString, attributes: [NSAttributedString.Key.font: self.countLabel.font!])
        if count != 0 {
            countLabelMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 1))
        }
        self.countLabel.attributedText = countLabelMutableString
    }
}
