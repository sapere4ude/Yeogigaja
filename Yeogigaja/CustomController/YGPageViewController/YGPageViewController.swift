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
    var pageCollection = PageCollection(pages: [Page(name: "pageCollection을", viewController: UIViewController()), Page(name: "설정해주세요", viewController: UIViewController())], selectedPageIndex: 0)
    var menuBarHeight: CGFloat?
    var delegate: YGPageViewControllerDelegate?

    private var pageViewController: UIPageViewController!
    private let menuBar = YGMenuBar()

    private var _menuBarHeight: CGFloat {
        return menuBarHeight ?? 65.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLeftBarMenuButton()
        setupMenuBar()
        setupPageViewController()
    }

    func setupNavigationBar() {
        navigationController?.setThemeAsDefault()
    }

    @IBAction private func onLeftBarMenuButtonClicked() {
        delegate?.YGLeftBarButtonSelected()
    }

    private func setupLeftBarMenuButton() {
        let barMenuButtonView = YGBarMenuButtonView(titleText: "경기도 하남시", leftImage: UIImage(named: "mapMarker"), rightImage: UIImage(named: "arrowDown"))
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
}

extension YGPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }

        guard let currentViewController = pageViewController.viewControllers?.first else { return }

        guard let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.viewController === currentViewController }) else { return }

        let indexPath = IndexPath(item: currentViewControllerIndex, section: 0)
        menuBar.selectMenuItem(at: indexPath, animated: true, scrollPosition: [])
        menuBar.scrollToMenuItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension YGPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.viewController === viewController }) {
            if (1 ..< pageCollection.pages.count).contains(currentViewControllerIndex) {
                pageCollection.selectedPageIndex = currentViewControllerIndex - 1
                return pageCollection.pages[currentViewControllerIndex - 1].viewController
            }
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.viewController === viewController }) {
            if (0 ..< (pageCollection.pages.count - 1)).contains(currentViewControllerIndex) {
                pageCollection.selectedPageIndex = currentViewControllerIndex + 1
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
        pageViewController.setViewControllers([pageCollection.pages[index].viewController], direction: direction, animated: true, completion: nil)
    }
}
