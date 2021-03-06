//
//  SceneDelegate.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/09/24.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        window?.backgroundColor = .white
        
        // TabBarController에서 SafeArea의 BottomInset 값을 가져오기 위해 window를 미리 key로 만들어줘야 한다
        window?.makeKey()
        
        let tbVC = TabBarController()
        
        //MARK: - 현재 Firebase 서버에 사용자가 존재하는지 여부를 판별하고 존재한다면 -> tableViewController, 존재하지않는다면 -> loginViewController 이동시킨다.
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            print("현재 존재하는 ID --->","\(FirebaseAuth.Auth.auth().currentUser)")
            window?.rootViewController = tbVC
        } else {
            print("존재하는 ID가 없어서 이쪽으로 넘어옴")
            let storyboard: UIStoryboard = UIStoryboard(name: "login", bundle: nil)
            let pushVC = storyboard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
            window?.rootViewController = pushVC
            window?.makeKeyAndVisible()
        }
        
    //Line50,51은 제가 작성한게 아니라 확인이 필요합니다.
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



