import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }

    static let navigationBarLabelColor: UIColor = .black
    static let navigationBarBackgroundColor: UIColor = .white
    
    static let tabBarLabelColor: UIColor = .black
    static let tabBarBackgroundColor: UIColor = .white
}
