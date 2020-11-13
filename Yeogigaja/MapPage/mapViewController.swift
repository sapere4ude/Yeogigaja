//
//  mapViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/09.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import GEOSwift
import geos
import MapKit
extension UIButton{

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = event!.touches(for: self)?.first {
            let location = touch.location(in: self)
            if alphaFromPoint(point: location) == 0 {
                self.cancelTracking(with: nil)
                print("cancelled!")
            } else{
                super.touchesBegan(touches, with: event)
            }
        }
    }

    func alphaFromPoint(point: CGPoint) -> CGFloat {
        var pixel: [UInt8] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let alphaInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: alphaInfo.rawValue)

        context!.translateBy(x: -point.x, y: -point.y)
        self.layer.render(in: context!)

        let floatAlpha = CGFloat(pixel[3])
        return floatAlpha
    }
}
class mapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {



}
