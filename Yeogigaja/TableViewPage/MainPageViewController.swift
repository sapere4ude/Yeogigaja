//
//  MainPageViewController.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/12/18.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class MainPageViewController: YGPageViewController {
    override func viewDidLoad() {
        setupPageCollection()
        super.viewDidLoad()
    }
    
    private func setupPageCollection() {
        let mainsb = UIStoryboard(name: "Main", bundle: nil)
        guard let view1 = mainsb.instantiateViewController(identifier: "tableView") as? TableViewController else{return}
        
        // 테스트를 위한 2번째 뷰
        let view2 = mainsb.instantiateViewController(identifier: "testView")
        
        let pages = [Page(name: "메인", viewController: view1), Page(name: "긴 이름으로 테스트 스크롤 잘 되는지 확인", viewController: view2)]
        
        self.pageCollection = PageCollection(pages: pages, selectedPageIndex: 0)
    }
}
