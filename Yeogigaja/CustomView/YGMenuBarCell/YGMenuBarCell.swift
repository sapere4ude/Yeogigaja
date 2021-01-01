import UIKit

class YGMenuBarCell: UICollectionViewCell {
    
    // YGMenuBarCell 내부에 들어가는 label의 객체를 생성하는 코드
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        // YGMenuBarCell의 label의 기본 text 값을 "탭"으로 지정
        label.text = "탭"
        // YGMenuBarCell의 label의 기본 font 값을 34pt의 bold systemFont로 지정
        label.font = UIFont.systemFont(ofSize: 34.0, weight: .bold)
        return label
    }()
    
    // YGMenuBarCell이 선택되었을 경우, 선택되지 않았을 경우의 색을 다르게 설정해주었다.
    override var isSelected: Bool {
        didSet{
            self.label.textColor = isSelected ? .black : .lightGray
        }
    }
    
    //xib 파일을 사용하였으므로 awakeFromNib 메소드에서 코드를 설정해주었다. xib와 nib는 모두 awakeFromNib 메소드 사용 가능
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label)
        
        // YGMenuBarCell의 가운데에 label이 오도록 설정함
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
