//
//  AddTagViewController.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/11/29.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class AddTagViewController: UIViewController {
    @IBOutlet var backingImageView: UIImageView!
    @IBOutlet var dimmerView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var handleView: UIView!
    @IBOutlet var tagTextField: UITextField!

    @IBOutlet var cardViewTopConstraint: NSLayoutConstraint!

    var backingImage: UIImage?

    let cardStartingTopConstant: CGFloat = 45.0
    var cardPanStartingTopConstant: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backingImageView.image = self.backingImage
        self.setView()
        self.setHandleView()
        self.setCardView()
        self.setDimmerView()
        self.setAnimationInitialValue()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showCard()
        self.tagTextField.becomeFirstResponder()
    }

    private func setView() {
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(self.viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        self.view.addGestureRecognizer(viewPan)
        
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(viewTap)
    }
    
    private func setHandleView() {
        self.handleView.clipsToBounds = true
        self.handleView.layer.cornerRadius = 3.0
    }

    private func setCardView() {
        self.cardView.clipsToBounds = false
        self.cardView.layer.cornerRadius = 10.0
        self.cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setDimmerView() {
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(self.dimmerViewTapped(_:)))
        self.dimmerView.addGestureRecognizer(dimmerTap)
        self.dimmerView.isUserInteractionEnabled = true
    }

    private func setAnimationInitialValue() {
        let keyWindows: UIWindow? = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if let safeAreaHeight = keyWindows?.safeAreaLayoutGuide.layoutFrame.height, let bottomPadding = keyWindows?.safeAreaInsets.bottom {
            self.cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }
        self.dimmerView.alpha = 0.0
    }

    private func showCard() {
        self.view.layoutIfNeeded()
        self.cardViewTopConstraint.constant = self.cardStartingTopConstant
        let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn) {
            self.view.layoutIfNeeded()
        }

        showCard.addAnimations {
            self.dimmerView.alpha = 0.7
        }

        showCard.startAnimation()
    }

    private func hideCardAndGoBack() {
        self.view.layoutIfNeeded()
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        self.cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn) {
            self.view.layoutIfNeeded()
        }

        hideCard.addAnimations {
            self.dimmerView.alpha = 0.0
        }

        hideCard.addCompletion { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }

        hideCard.startAnimation()
    }

    private func dimAlphaWithCardTopConstraint(value: CGFloat) -> CGFloat {
        let fullDimAlpha: CGFloat = 0.7

        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom

        let fullDimPosition = self.cardStartingTopConstant
        let noDimPosition = safeAreaHeight + bottomPadding

        if value < fullDimPosition {
            return fullDimAlpha
        }

        if value > noDimPosition {
            return 0.0
        }

        return fullDimAlpha * (1 - ((value - fullDimPosition) / (noDimPosition - fullDimPosition)))
    }

    @IBAction func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        self.hideCardAndGoBack()
    }

    @IBAction func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        let transition = panRecognizer.translation(in: self.view)
        
        self.hideKeyboard()
        
        switch panRecognizer.state {
        case .began:
            self.cardPanStartingTopConstant = self.cardViewTopConstraint.constant
        case .changed:
            if self.cardPanStartingTopConstant + transition.y > self.cardStartingTopConstant {
                self.cardViewTopConstraint.constant = self.cardPanStartingTopConstant + transition.y
            }
            self.dimmerView.alpha = self.dimAlphaWithCardTopConstraint(value: self.cardViewTopConstraint.constant)
        case .ended:
            let velocity = panRecognizer.velocity(in: self.view)
            if velocity.y > 1500.0 {
                self.hideCardAndGoBack()
                return
            }
            let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding = view.safeAreaInsets.bottom
            if self.cardViewTopConstraint.constant < (safeAreaHeight + bottomPadding) * 0.5 {
                self.showCard()
            } else {
                self.hideCardAndGoBack()
            }
        default:
            break
        }
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    @IBAction func addTagViewViewCancelPressed(sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func addTagViewViewDonePressed(sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
}
