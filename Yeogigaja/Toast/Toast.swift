import UIKit

class Toast {
    static var toastAnimator: UIViewPropertyAnimator?

    private static func createToastLabel(message: String, font: UIFont) -> UILabel {
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        return toastLabel
    }

    private static func startToastAnimation(container toastContainer: UIView) {
        self.toastAnimator = UIViewPropertyAnimator(duration: 4.0, curve: .easeOut) {
            toastContainer.alpha = 0.0
        }
        self.toastAnimator?.addCompletion { _ in
            toastContainer.removeFromSuperview()
        }
        self.toastAnimator?.startAnimation()
    }

    private static func finishToastAnimation() {
        self.toastAnimator?.stopAnimation(false)
        self.toastAnimator?.finishAnimation(at: .current)
    }
    
    static func show(message: String, font: UIFont, in view: UIView) {
        finishToastAnimation()
        
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 1.0
        toastContainer.layer.cornerRadius = 10.0;
        toastContainer.clipsToBounds  =  true

        let toastLabel = createToastLabel(message: message, font: font)

        toastContainer.addSubview(toastLabel)
        view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false

        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 16.0)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -16.0)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -8.0)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 8.0)
        toastContainer.addConstraints([a1, a2, a3, a4])

        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .width, relatedBy: .lessThanOrEqual, toItem: view, attribute: .width, multiplier: 1, constant: -90.0)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 1)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -40.0)
        view.addConstraints([c1, c2, c3])

        startToastAnimation(container: toastContainer)
    }
}
