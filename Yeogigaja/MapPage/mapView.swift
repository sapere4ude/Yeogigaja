//
//  mapView.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/07.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

@IBDesignable
class mapView: UIButton{

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0, y:0))
        path.addLine(to: CGPoint(x:0, y:98))
        path.addLine(to: CGPoint(x:40, y:98))
        path.addLine(to: CGPoint(x:40, y:70))
        path.addLine(to: CGPoint(x:98, y:70))
        path.addLine(to: CGPoint(x:98, y:0))
        path.lineWidth = 3
        path.close()
        path.stroke()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
