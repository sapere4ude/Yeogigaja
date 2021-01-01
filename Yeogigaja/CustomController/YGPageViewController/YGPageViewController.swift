//
//  ViewController.swift
//  AdditionalNavBar2
//
//  Created by 김진태 on 2020/12/15.
//

import UIKit

protocol YGPageViewControllerDelegate {
    func YGLeftBarButtonSelected()
}

class YGPageViewController: UIViewController {
    // MARK: - Properties

    var pageCollection = PageCollection(pages: [Page(name: "pageCollection을", viewController: UIViewController()), Page(name: "설정해주세요", viewController: UIViewController())], selectedPageIndex: 0)
    var menuBarHeight: CGFloat?
    var delegate: YGPageViewControllerDelegate?

    var useLeftBarMenuButton: Bool = false
    var leftBarButtonLeftImage: UIImage?
    var leftBarButtonRightImage: UIImage?
    var leftBarButtonTitleText: String?
    var leftBarButtonLeftImageSize: CGSize?
    var leftBarButtonRightImageSize: CGSize?
    var disablesFirstAndLastPageBounce: Bool = false
    /**
            Page View의 Swipe Gesture를 Disable 시키는 프로퍼티. 기본값은 true이다.
     */
    var disableSwipeGesture: Bool {
        return true
    }

    private var pageViewController: UIPageViewController!
    private let menuBar = YGMenuBar()

    private var _menuBarHeight: CGFloat {
        return menuBarHeight ?? 65.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if useLeftBarMenuButton {
            setupLeftBarMenuButton()
        }
        setupMenuBar()
        setupPageViewController()
        if disableSwipeGesture {
            removeSwipeGesture()
        }
    }

    func setupNavigationBar() {
        navigationController?.setThemeAsDefault()
    }

    @IBAction private func onLeftBarMenuButtonClicked() {
        delegate?.YGLeftBarButtonSelected()
    }

    private func setupLeftBarMenuButton() {
        let barMenuButtonView = YGBarMenuButtonView(titleText: leftBarButtonTitleText, leftImage: leftBarButtonLeftImage, rightImage: leftBarButtonRightImage, leftImageSize: leftBarButtonLeftImageSize, rightImageSize: leftBarButtonRightImageSize)
        let leftBarMenuButton = UIBarButtonItem(customView: barMenuButtonView)
        let leftBarMenuButtonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onLeftBarMenuButtonClicked))
        leftBarMenuButton.customView?.addGestureRecognizer(leftBarMenuButtonGestureRecognizer)
        navigationItem.leftBarButtonItem = leftBarMenuButton
    }

    private func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.delegate = self
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: _menuBarHeight).isActive = true
        menuBar.menuTitles = pageCollection.pages.map { (page) -> String in
            page.name
        }
    }

    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([pageCollection.pages[0].viewController], direction: .forward, animated: false, completion: nil)
        
        addChild(pageViewController)
        pageViewController.willMove(toParent: self)
        view.addSubview(pageViewController.view)
        layoutPageView()
    }

    private func layoutPageView() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // Swipe Gesture를 사용하지 않도록 하는 메소드
    func removeSwipeGesture(){
        for view in self.pageViewController!.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
}

extension YGPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }

        guard let currentViewController = pageViewController.viewControllers?.first else { return }

        guard let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.viewController === currentViewController }) else { return }

        pageCollection.selectedPageIndex = currentViewControllerIndex

        let indexPath = IndexPath(item: currentViewControllerIndex, section: 0)
        
        menuBar.selectMenuItem(at: indexPath, animated: false, scrollPosition: [])
        menuBar.scrollToMenuItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension YGPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.viewController === viewController }) {
            if (1 ..< pageCollection.pages.count).contains(currentViewControllerIndex) {
                return pageCollection.pages[currentViewControllerIndex - 1].viewController
            }
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.viewController === viewController }) {
            if (0 ..< (pageCollection.pages.count - 1)).contains(currentViewControllerIndex) {
                return pageCollection.pages[currentViewControllerIndex + 1].viewController
            }
        }

        return nil
    }
}

extension YGPageViewController: YGMenuBarDelegate {
    func menuBar(scrollTo index: Int) {
        if index == pageCollection.selectedPageIndex {
            return
        }
        let direction: UIPageViewController.NavigationDirection
        if index < pageCollection.selectedPageIndex {
            direction = .reverse
        } else {
            direction = .forward
        }
        pageCollection.selectedPageIndex = index
        pageViewController.setViewControllers([pageCollection.pages[index].viewController], direction: direction, animated: false, completion: nil)
    }
}
