//
//  mainPageTableViewCell.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/04.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class tableViewCell: UITableViewCell {
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var entryDetailLabel: UILabel!
    @IBOutlet weak var entryAreaLabel: UILabel!
    @IBOutlet weak var entryView: UIView! {
        didSet {
            entryView.layer.cornerRadius = 8
            entryView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        entryTitleLabel?.text = "QQQ"
        entryDetailLabel?.text = "BBB"
        entryAreaLabel?.text = "www"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacingBetweenCells: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        self.contentView.frame = self.contentView.frame.inset(by: spacingBetweenCells)
    }
}
