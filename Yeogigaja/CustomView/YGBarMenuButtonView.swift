import UIKit

class YGBarMenuButtonView: UIView {
    var leftImage: UIImage?
    var rightImage: UIImage?
    var titleText: String?

    var rightImageSize: CGSize?
    var leftImageSize: CGSize?

    var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private var _rightImageSize: CGSize {
        return rightImageSize ?? CGSize(width: 15.0, height: 10.0)
    }

    private var _leftImageSize: CGSize {
        return leftImageSize ?? CGSize(width: 18.0, height: 24.0)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(titleText: String?, leftImage: UIImage?, rightImage: UIImage?) {
        self.init(frame: CGRect(x: 0.0, y: 0.0, width: 128.0, height: 33.0))
        self.titleText = titleText
        self.leftImage = leftImage
        self.rightImage = rightImage
        setupView()
    }
    
    convenience init(titleText: String?, leftImage: UIImage?, rightImage: UIImage?, leftImageSize: CGSize?, rightImageSize: CGSize?) {
        self.init(frame: CGRect(x: 0.0, y: 0.0, width: 128.0, height: 33.0))
        self.leftImageSize = leftImageSize
        self.rightImageSize = rightImageSize
        self.titleText = titleText
        self.leftImage = leftImage
        self.rightImage = rightImage
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupView() {
        addSubview(stackView)
        setupStackView()
    }

    private func setupStackView() {
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        let leftImageView = UIImageView(image: leftImage)

        leftImageView.frame = CGRect(x: 0.0, y: 0.0, width: _leftImageSize.width, height: _leftImageSize.height)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.widthAnchor.constraint(equalToConstant: _leftImageSize.width).isActive = true
        leftImageView.heightAnchor.constraint(equalToConstant: _leftImageSize.height).isActive = true

        let rightImageView = UIImageView(image: rightImage)

        rightImageView.frame = CGRect(x: 0.0, y: 0.0, width: _rightImageSize.width, height: _rightImageSize.height)
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.widthAnchor.constraint(equalToConstant: _rightImageSize.width).isActive = true
        rightImageView.heightAnchor.constraint(equalToConstant: _rightImageSize.height).isActive = true

        stackView.addArrangedSubview(leftImageView)
        if let titleText = titleText {
            let label = UILabel()
            label.text = titleText
            label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.8
            stackView.addArrangedSubview(label)
        }
        stackView.addArrangedSubview(rightImageView)
    }
}
