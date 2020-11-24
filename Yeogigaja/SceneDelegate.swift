//
//  SceneDelegate.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/09/24.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        let loginVC = loginViewController()
//        self.window?.rootViewController = loginVC
//
        let tbVC = UITabBarController()
        let mainsb = UIStoryboard(name: "Main", bundle: nil)
        guard let view1 = mainsb.instantiateViewController(identifier: "tableViewNavigation") as? UINavigationController else{return}
        let mapsb = UIStoryboard(name: "Map", bundle: nil)
        guard let view2 = mapsb.instantiateViewController(identifier: "MapView") as? mapViewController else{return}
        let calendarsb = UIStoryboard(name: "Calendar", bundle: nil)
        guard let view3 = calendarsb.instantiateViewController(identifier: "CalendarView") as? CalendarViewController else{return}
        let mypagesb = UIStoryboard(name: "Mypage", bundle: nil)
        guard let view4 = mypagesb.instantiateViewController(identifier: "MypageView") as? MypageViewController else{return}

        self.window?.rootViewController = tbVC

        tbVC.setViewControllers([view1, view2, view3, view4], animated: false)

        //MARK:- image 수정 필요
        view1.tabBarItem = UITabBarItem(title: "전체 항목", image: nil, tag: 0)
        view2.tabBarItem = UITabBarItem(title: "지역별 항목", image: nil, tag: 1)
        view3.tabBarItem = UITabBarItem(title: "캘린더", image: nil, tag: 2)
        view4.tabBarItem = UITabBarItem(title: "마이페이지", image: nil, tag: 3)
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}



