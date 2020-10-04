//
//  mainPageTableViewCell.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/04.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class mainPageTableViewCell: UITableViewCell {
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var entryDetailLabel: UILabel!
    @IBOutlet weak var entryAreaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
