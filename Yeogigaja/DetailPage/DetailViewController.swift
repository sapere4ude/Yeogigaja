//
//  DetailViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/04.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import Parchment
import UIKit

class DetailViewController: UITableViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cellIdentifier = String(describing: DetailTableViewCell.self)
            let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell

            cell.titleLabel.text = "메모"
            cell.infoLabel.text = "2020/11/02 (월)"
            cell.descriptionLabel.text = "영화 의뢰인 속 배우 하정우도 맛있게 흡입한 현지의 맛 가득 담은 베트남 음식점!! 00 이랑 다음에 가야겠다:-)"
            cell.selectionStyle = .none
            
            cell.separatorView.isHidden = false

            return cell
        case 1:
            let cellIdentifier = String(describing: DetailTableViewCell.self)
            let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell

            cell.titleLabel.text = "같이 가고 싶은 사람"
            cell.infoLabel.text = "총 5명"
            cell.descriptionLabel.text = "ㅇㅇㅇ / ㅇㅇㅇ / ㅇㅇㅇ / ㅇㅇㅇ / ㅇㅇㅇ"
            cell.selectionStyle = .none
            
            cell.separatorView.isHidden = true

            return cell
        default:
            fatalError("Detail View Controller의 cellForRowAt 메소드에서 엉뚱한 인덱스에 접근하였습니다")
        }
    }
}

extension UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
