//
//  localViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/07.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class localViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("local")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
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
