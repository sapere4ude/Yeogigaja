//
//  TabBarController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/10.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import FirebaseAuth

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
    
    
    func setupTabbar(){
        let view1 = MainPageViewController()
        let mapsb = UIStoryboard(name: "Map", bundle: nil)
        guard let view2 = mapsb.instantiateViewController(identifier: "MapView") as? mapViewController else{return}
        let calendarsb = UIStoryboard(name: "Calendar", bundle: nil)
        guard let view3 = calendarsb.instantiateViewController(identifier: "CalendarView") as? CalendarViewController else{return}
        let mypagesb = UIStoryboard(name: "Mypage", bundle: nil)
        guard let view4 = mypagesb.instantiateViewController(identifier: "MypageView") as? MypageViewController else{return}
        
        let navVC1 = UINavigationController(rootViewController: view1)
        let navVC2 = UINavigationController(rootViewController: view2)
        let navVC3 = UINavigationController(rootViewController: view3)
        let navVC4 = UINavigationController(rootViewController: view4)

        self.setViewControllers([navVC1, navVC2, navVC3, navVC4], animated: false)

        //MARK:- image 수정 필요
        navVC1.tabBarItem = UITabBarItem(title: "전체 항목", image: nil, tag: 0)
        navVC2.tabBarItem = UITabBarItem(title: "지역별 항목", image: nil, tag: 1)
        navVC3.tabBarItem = UITabBarItem(title: "캘린더", image: nil, tag: 2)
        navVC4.tabBarItem = UITabBarItem(title: "마이페이지", image: nil, tag: 3)
        
    }
}
