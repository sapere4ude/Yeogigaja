//
//  IndicatorTableViewCell.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/12/25.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class IndicatorTableViewCell: UITableViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!

    func animationIndicatorView() {
        indicator.startAnimating()
    }
    

}
