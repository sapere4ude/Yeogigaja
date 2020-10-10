//
//  TabBarController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/10.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabbar()

        // Do any additional setup after loading the view.
    }
    
    
    func tabbar(){
        guard let tableView = self.storyboard?.instantiateViewController(withIdentifier: "tableView") else{return}

        let mapSb = UIStoryboard(name: "Map", bundle: nil)
        guard let map = mapSb.instantiateViewController(withIdentifier: "MapView") as? mapViewController else{return}

        let CalendarSb = UIStoryboard(name: "Calendar", bundle: nil)
        guard let calendar = CalendarSb.instantiateViewController(withIdentifier: "CalendarView") as? CalendarViewController else{return}

        let myPageSb = UIStoryboard(name: "Mypage", bundle: nil)
        guard let myPage = myPageSb.instantiateViewController(withIdentifier: "MypageView") as? MypageViewController else{return}
        let pages = [tableView, map, calendar, myPage]
        
        //MARK:  image 수정 필요
        let items = [
            UITabBarItem(title: "전체항목", image: UIImage(named: "tes1"), tag: 0),
            UITabBarItem(title: "지역별", image: UIImage(named: "tes1"), tag: 1),
            UITabBarItem(title: "일정", image: UIImage(named: "tes1"), tag: 2),
            UITabBarItem(title: "my Page", image: UIImage(named: "tes1"), tag: 3),
        ]
        
        (0..<items.count).forEach{ pages[$0].tabBarItem = items[$0]}
        self.setViewControllers([tableView, map, calendar, myPage], animated: true)
        print("pages count", pages.count)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
