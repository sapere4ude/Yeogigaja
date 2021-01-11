//
//  TabBarController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/10.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import FirebaseAuth
import UIKit

class TabBarController: UITabBarController {
    // MARK: - Lifecycle

    private var centerViewController: UIViewController!
    var tabBarTitleRemoved: Bool = false
    var centerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
        setupTabbar()
        setupCenterTabBarButton()
    }

    // MARK: - 탭바 컨트롤러 설정 메소드

    /** 탭바 컨트롤러에 뷰 컨트롤러를 붙이고, 탭바에 나타날 이미지와 타이틀을 설정하는 메소드 */
    private func setupTabBarController() {
        let vc1 = MainPageViewController()
        let mapsb = UIStoryboard(name: "Map", bundle: nil)
        guard let vc2 = mapsb.instantiateViewController(identifier: "MapView") as? mapViewController else { return }
        let calendarsb = UIStoryboard(name: "Calendar", bundle: nil)

        guard let vc3 = calendarsb.instantiateViewController(identifier: "CalendarView") as? CalendarViewController else { return }
        let mypagesb = UIStoryboard(name: "Mypage", bundle: nil)
        guard let vc4 = mypagesb.instantiateViewController(identifier: "MypageView") as? MypageViewController else { return }

        // centerViewController는 임의의 UIViewController 객체로 설정하였다. 나중에 수정할 예정
        centerViewController = UINavigationController(rootViewController: UIViewController())
        centerViewController.modalPresentationStyle = .fullScreen

        let dummyViewController = centerViewController as! UINavigationController

        // 각 뷰 컨트롤러는 모두 네비게이션 컨트롤러를 갖도록 설정한다.
        let navVC1 = UINavigationController(rootViewController: vc1)
        let navVC2 = UINavigationController(rootViewController: vc2)
        let navVC3 = UINavigationController(rootViewController: vc3)
        let navVC4 = UINavigationController(rootViewController: vc4)

        // navVC1의 네비게이션 바의 배경 색, 글자 색 등을 Extension을 이용해 구현한 메소드로 설정해줌.
        navVC1.setThemeAsDefault()

        setViewControllers([navVC1, navVC2, dummyViewController, navVC3, navVC4], animated: false)

        navVC1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 0)
        navVC2.tabBarItem = UITabBarItem(title: "지도", image: UIImage(named: "mapWithMarker"), tag: 1)

        /*  탭바의 가운데에 UITabBarItem과 UIButton이 함께 존재한다
         centerViewController의 UITabBarItem은 공간을 차지하기 위해 더미로 넣은 것이므로 title, image를 null로 지정
         UITabBarItem을 터치하였을 때 UIButton과 함께 작동하지 않도록 하기 위해 isEnabled를 false로 지정 */
        dummyViewController.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        dummyViewController.tabBarItem.isEnabled = false

        navVC3.tabBarItem = UITabBarItem(title: "캘린더", image: UIImage(named: "calendar"), tag: 3)
        navVC4.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "user"), tag: 4)
    }

    //    MARK: - 탭바 설정 메소드

    /**  탭바의 글자색, 배경색, 반투명 여부 설정 */
    private func setupTabbar() {
        tabBar.tintColor = UIColor.tabBarLabelColor
        tabBar.barTintColor = UIColor.tabBarBackgroundColor
        tabBar.isTranslucent = false
    }

    //    MARK: - 탭바의 타이틀 제거 메소드

    /**
     - 참조 링크 : https://www.manongdao.com/article-1775265.html
     - 설명 : 탭바에 이미지만 나타나도록 설정해주는 메소드. 6.0이라는 값은 UITabBarItem의 라벨의 높이인 듯 하다. 6.0이라는 값은 OS 버전 관계 없이 고정적.
          */
    private func removeTabBarTitle() {
        guard let items = tabBar.items else {
            return
        }
        for item in items {
            item.title = ""
            item.imageInsets = UIEdgeInsets(top: 6.0, left: 0, bottom: -6.0, right: 0)
        }
        tabBarTitleRemoved = true
    }

    // MARK: - 탭바의 가운데 버튼 모양을 설정해주는 메소드

    /**
        탭바의 가운데에 우리가 설정한 모양의 버튼을 '새로 추가'해주는 메소드이다.
     */
    private func setupCenterTabBarButton() {
        let centerButtonHeight: CGFloat = 40.0
        let centerButtonWidth: CGFloat = centerButtonHeight

        centerButton = UIButton(type: .custom)
        centerButton.frame = CGRect(x: 0.0, y: 0.0, width: centerButtonWidth, height: centerButtonHeight)

        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        let safeAreaInsetBottom: CGFloat = keyWindow?.safeAreaInsets.bottom ?? 0.0

        var centerY = tabBar.center.y - safeAreaInsetBottom
        if tabBarTitleRemoved { centerY += 6.0 }
        let center = CGPoint(x: tabBar.center.x, y: centerY)
        centerButton.center = center

        let centerButtonImage = UIImage(named: "add-small")?.withTintColor(.white)
        centerButton.setImage(centerButtonImage, for: .normal)
        centerButton.adjustsImageWhenHighlighted = false
        centerButton.backgroundColor = UIColor.tabBarCenterButtonColor

        centerButton.layer.cornerRadius = centerButton.frame.width / 2.0
        centerButton.clipsToBounds = true

        centerButton.addTarget(self, action: #selector(showCenterViewController), for: .touchUpInside)
        view.addSubview(centerButton)
    }

    @objc private func showCenterViewController() {
        present(centerViewController, animated: true, completion: nil)
    }
}
