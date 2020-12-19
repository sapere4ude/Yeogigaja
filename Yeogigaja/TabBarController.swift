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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
        setupTabbar()
        removeTabBarTitle()
    }

    private func setupTabBarController() {
        let view1 = MainPageViewController()
        let mapsb = UIStoryboard(name: "Map", bundle: nil)
        guard let view3 = mapsb.instantiateViewController(identifier: "MapView") as? mapViewController else { return }
        let calendarsb = UIStoryboard(name: "Calendar", bundle: nil)
        guard let view4 = calendarsb.instantiateViewController(identifier: "CalendarView") as? CalendarViewController else { return }
        let mypagesb = UIStoryboard(name: "Mypage", bundle: nil)
        guard let view5 = mypagesb.instantiateViewController(identifier: "MypageView") as? MypageViewController else { return }

        let navVC1 = UINavigationController(rootViewController: view1)
        let navVC2 = UINavigationController(rootViewController: UIViewController())
        let navVC3 = UINavigationController(rootViewController: view3)
        let navVC4 = UINavigationController(rootViewController: view4)
        let navVC5 = UINavigationController(rootViewController: view5)

        setViewControllers([navVC1, navVC2, navVC3, navVC4, navVC5], animated: false)

        // MARK: - image 수정 필요

        navVC1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 0)
        navVC2.tabBarItem = UITabBarItem(title: "검색", image: UIImage(named: "search"), tag: 1)
        navVC3.tabBarItem = UITabBarItem(title: "핀", image: UIImage(named: "pin"), tag: 2)
        navVC4.tabBarItem = UITabBarItem(title: "캘린더", image: UIImage(named: "calendar"), tag: 3)
        navVC5.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "user"), tag: 4)
    }
    
    private func setupTabbar() {
        tabBar.tintColor = UIColor.tabBarLabelColor
        tabBar.barTintColor = UIColor.tabBarBackgroundColor
        tabBar.isTranslucent = false
    }

    // 참조 링크 : https://www.manongdao.com/article-1775265.html
    private func removeTabBarTitle() {
        guard let items = tabBar.items else {
            return
        }
        for item in items {
            item.title = ""
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}
