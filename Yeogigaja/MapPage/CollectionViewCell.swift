//
//  CollectionViewCell.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/06.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
       
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let cellBackground = UIView()
        let gradient = CAGradientLayer()
//        gradientLayer.frame.size = cell.frame.size
//        gradientLayer.colors = [#colorLiteral(red: 0.9338900447, green: 0.4315618277, blue: 0.2564975619, alpha: 1),#colorLiteral(red: 0.8518816233, green: 0.1738803983, blue: 0.01849062555, alpha: 1)]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//        cell.backgroundView = cellBackground
//        cell.backgroundView?.layer.addSublayer(gradientLayer)
//        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
//
//        if let gradient = gradient {
//            gradient.frame = bgView.bounds
//        } else {
//            gradient = TestCell.createGradientLayer(for: bgView)
//            bgView.layer.addSublayer(gradient!)
        }
}
