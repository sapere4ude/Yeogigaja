//
//  MainPageViewController.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/12/18.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class MainPageViewController: YGPageViewController {
    
    // 스와이프 제스쳐 비활성화. 원래 true가 기본값으로 지정되어 있으나 수정의 용이성을 위해 일부러 코드로 작성
    override var disableSwipeGesture: Bool {
        return true
    }
    
    // MARK: - MainPageViewController의 Lifecycle
    override func viewDidLoad() {
        self.setupMainPageViewController()
        // YGPageViewController가 구현된 방식으로 인해 super.viewDidLoad가 제일 마지막 라인에서 실행되어야 함
        super.viewDidLoad()
    }
    
    // MARK: - MainPageViewController를 설정해주는 메소드
    private func setupMainPageViewController() {
        self.setupPageCollection()
        
        // 네비게이션 바에 나타나는 LeftBarButton과 관련된 프로퍼티들 설정
        self.useLeftBarMenuButton = true
        self.leftBarButtonTitleText = "서울시 강동구"
        self.leftBarButtonLeftImage = UIImage(named: "mapMarker")
        self.leftBarButtonRightImage = UIImage(named: "arrowDown")
        
        // 내비게이션 바에 나타나는 RightBarButton 설정
        let rightBarButtonImage = UIImage(named: "search")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightBarButtonImage, style: .plain, target: self, action: nil)
    }
    
    // MARK: - MainPageViewController의 PageViewController를 설정해주는 메소드
    // MainPageViewController에서 스크롤 또는 상단 메뉴를 선턱해 이동할 수 있는 ViewController들을 설정해주는 역할을 한다
    private func setupPageCollection() {
        let mainsb = UIStoryboard(name: "Main", bundle: nil)
        guard let view1 = mainsb.instantiateViewController(identifier: "tableView") as? TableViewController else { return }
        
        // 테스트를 위해 넣어준 2번째 뷰
        let view2 = mainsb.instantiateViewController(identifier: "testView")
        
        // 테스트를 위해 넣어준 3번째 뷰
        let view3 = mainsb.instantiateViewController(identifier: "anotherView")
        
        let pages = [Page(name: "메인", viewController: view1), Page(name: "서브", viewController: view2), Page(name: "서브2", viewController: view3)]
        
        self.pageCollection = PageCollection(pages: pages, selectedPageIndex: 0)
    }
}
