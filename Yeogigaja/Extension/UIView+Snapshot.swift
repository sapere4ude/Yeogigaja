//
//  UIView+Extension.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/11/30.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

extension UIView {
    // render the view within the view's bounds, then capture it as image
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
