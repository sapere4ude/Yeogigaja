import UIKit

class YGMenuBarCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "탭"
        label.font = UIFont.systemFont(ofSize: 34.0, weight: .bold)
        return label
    }()
    override var isSelected: Bool {
        didSet{
            self.label.textColor = isSelected ? .black : .lightGray
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
