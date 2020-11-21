import UIKit

@objc protocol RoundedTextViewDelegate {
    @objc optional func roundedTextViewDidChangeText(_ text:String)
    @objc optional func roundedTextViewDidEndEditing(_ text:String)
    func roundedTextViewDidReturnPressed()
}

final class RoundedTextView: UITextView {

    var notifier:RoundedTextViewDelegate?

    var placeholder: String? {
        didSet {
            placeholderLabel?.text = placeholder
        }
    }
    var placeholderColor = UIColor.lightGray
    var placeholderFont = UIFont.systemFont(ofSize: 14.0) {
        didSet {
            placeholderLabel?.font = placeholderFont
        }
    }

    fileprivate var placeholderLabel: UILabel?

    // MARK: - LifeCycle

    init() {
        super.init(frame: CGRect.zero, textContainer: nil)
        awakeFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(RoundedTextView.textDidChangeHandler(notification:)), name: UITextView.textDidChangeNotification, object: nil)

        placeholderLabel = UILabel()
        placeholderLabel?.textColor = placeholderColor
        placeholderLabel?.text = placeholder
        placeholderLabel?.textAlignment = .left
        placeholderLabel?.numberOfLines = 0
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        placeholderLabel?.font = placeholderFont

        var height:CGFloat = placeholderFont.lineHeight
        if let data = placeholderLabel?.text {

            let expectedDefaultWidth:CGFloat = bounds.size.width
            let fontSize:CGFloat = placeholderFont.pointSize

            let textView = UITextView()
            textView.text = data
            textView.font = UIFont.systemFont(ofSize: fontSize)
            let sizeForTextView = textView.sizeThatFits(CGSize(width: expectedDefaultWidth,
                                                               height: CGFloat.greatestFiniteMagnitude))
            let expectedTextViewHeight = sizeForTextView.height

            if expectedTextViewHeight > height {
                height = expectedTextViewHeight
            }
        }

        placeholderLabel?.frame = CGRect(x: 5, y: 0, width: bounds.size.width - 16, height: height)

        if text.isEmpty {
            self.addSubview(placeholderLabel!)
            self.bringSubviewToFront(placeholderLabel!)
        } else {
            placeholderLabel?.removeFromSuperview()
        }
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }

    @objc func textDidChangeHandler(notification: Notification) {
        self.layoutSubviews()
    }

}

extension RoundedTextView : UITextViewDelegate {
    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            notifier?.roundedTextViewDidReturnPressed()
            return false
        }
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        notifier?.roundedTextViewDidChangeText?(textView.text)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        notifier?.roundedTextViewDidEndEditing?(textView.text)
    }
}
