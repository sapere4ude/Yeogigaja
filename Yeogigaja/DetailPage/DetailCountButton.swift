//
//  DetailCountButton.swift
//  Yeogigaja
//
//  Created by 김진태 on 2021/01/12.
//  Copyright © 2021 sapere4ude. All rights reserved.
//

import UIKit

class DetailCountButton: UIStackView {
    @IBOutlet var iconImageView: UIImageView? {
        didSet {
            if isHighlighted == false {
                iconImageView?.image = iconImage
            } else {
                iconImageView?.image = highlightedIconImage
            }
        }
    }
    @IBOutlet var textLabel: UILabel? {
        didSet {
            textLabel?.text = text
        }
    }
    var text: String {
        get {
            return _text
        } set {
            _text = newValue
            textLabel?.text = newValue
        }
    }
    var iconImage: UIImage? {
        get {
            return _iconImageWithTintColor
        }
        set {
            guard let newIconImage = newValue else { return }
            if iconImage != nil && newIconImage.isEqual(iconImage) == true { return }
            _iconImageWithTintColor = newIconImage.withTintColor(iconImageColor, renderingMode: .alwaysOriginal)
            _iconImageWithHighlightedTintColor = newIconImage.withTintColor(highlightedIconImageColor, renderingMode: .alwaysOriginal)
            if isHighlighted == false {
                iconImageView?.image = _iconImageWithTintColor
            }
        }
    }

    var highlightedIconImage: UIImage? {
        get {
            if let image = _highlightedIconImageWithTintColor {
                return image
            }
            return _iconImageWithHighlightedTintColor
        }
        set {
            guard let newIconImage = newValue else { return }
            if highlightedIconImage != nil && newIconImage.isEqual(highlightedIconImage) == true { return }
            _highlightedIconImageWithTintColor = newIconImage.withTintColor(highlightedIconImageColor, renderingMode: .alwaysOriginal)
            if isHighlighted == true {
                iconImageView?.image = _highlightedIconImageWithTintColor
            }
        }
    }

    var iconImageColor: UIColor {
        get {
            return _iconImageColor
        }
        set {
            if _iconImageColor == newValue { return }
            _iconImageColor = newValue
            guard let currentIconImageWithTintColor = _iconImageWithTintColor else { return }
            _iconImageWithTintColor = currentIconImageWithTintColor.withTintColor(iconImageColor)
            if isHighlighted == false {
                iconImageView?.image = _iconImageWithTintColor
            }
        }
    }

    var highlightedIconImageColor: UIColor {
        get {
            return _highlightedIconImageColor
        }
        set {
            if _highlightedIconImageColor == newValue { return }
            _highlightedIconImageColor = newValue
            guard let currentIconImageWithTintColor = _highlightedIconImageWithTintColor else { return }
            _highlightedIconImageWithTintColor = currentIconImageWithTintColor.withTintColor(highlightedIconImageColor)
            if isHighlighted == true {
                iconImageView?.image = _highlightedIconImageWithTintColor
            }
        }
    }

    var isHighlighted: Bool {
        get {
            return _isHighlighted
        }
        set {
            if newValue == false {
                iconImageView?.image = iconImage
            } else {
                iconImageView?.image = highlightedIconImage
            }
            _isHighlighted = newValue
        }
    }

    private var _iconImageColor: UIColor = .darkGray
    private var _highlightedIconImageColor: UIColor = .black
    private var _isHighlighted: Bool = false
    
    private var _iconImageWithTintColor: UIImage?
    private var _iconImageWithHighlightedTintColor: UIImage?
    private var _highlightedIconImageWithTintColor: UIImage?
    private var _text: String = ""
}
