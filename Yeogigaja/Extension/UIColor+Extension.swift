import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }

    static let primaryColor: UIColor = UIColor(red: 240, green: 62, blue: 62)
    
    static let navigationBarLabelColor: UIColor = .black
    static let navigationBarBackgroundColor: UIColor = .white
    
    static let tabBarLabelColor: UIColor = .black
    static let tabBarBackgroundColor: UIColor = .white

    static let tabBarCenterButtonColor: UIColor = primaryColor
}
