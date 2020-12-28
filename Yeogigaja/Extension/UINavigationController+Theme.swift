import UIKit

// 통일성을 유지하기 위해 Extension을 이용하여 UINavigationController의 Theme를 설정하는 코드 작성 - 김진태

extension UINavigationController {
    /*
        사용법 : navigationController?.setThemeAsDefault()
     */
    func setThemeAsDefault() {
        self.navigationBar.tintColor = UIColor.navigationBarLabelColor
        self.navigationBar.barTintColor = UIColor.navigationBarBackgroundColor
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.isTranslucent = false
    }
    
    func setThemeAsDarkTranslucent() {
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor.black
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.isTranslucent = true
    }
}
