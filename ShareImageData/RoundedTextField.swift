//
//  RoundedTextField.swift
//  ShareImageData
//
//  Created by 김진태 on 2020/11/17.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    let padding: UIEdgeInsets = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 0.0)
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
}
