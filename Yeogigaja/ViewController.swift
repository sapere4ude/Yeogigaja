//
//  ViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/05.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import Parchment

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        
        let pagingViewController = PagingViewController()
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.dataSource = self

        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        ])

        // Do any additional setup after loading the view.
    }
    


}
extension ViewController: PagingViewControllerDataSource {
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return 2
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        
        let tableViewController = self.storyboard?.instantiateViewController(identifier: "tableViewController")
        let locationViewController = self.storyboard?.instantiateViewController(identifier: "locationViewController")
        
        switch index {
        case 0:
            return tableViewController!
        case 1:
            return locationViewController!
        default:
            return tableViewController!
        }
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        switch index {
        case 0:
            return PagingIndexItem(index: index, title: "전체 항목")
        case 1:
            return PagingIndexItem(index: index, title: "지역별")
        default:
            return PagingIndexItem(index: index, title: "전체 항목")
        }
        
        
    }
    
  
}
