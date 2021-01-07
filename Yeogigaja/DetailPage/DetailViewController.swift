//
//  DetailViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/04.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import Parchment
import UIKit
import FirebaseDatabase
import FirebaseAuth

class DetailViewController: UITableViewController {
    
//    var fetchInfos: [fetchInfo] = []
    var titleLabel: String? = ""
    var descriptionLabel: String? = ""
    var withFriendsLabel: String? = ""
    var locationLabel: String? = ""
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        print("얍")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setThemeAsDarkTranslucent()
//
//        let userEmail = Auth.auth().currentUser?.email
//        var safeEmail = userEmail!.replacingOccurrences(of: ".", with: "-") // 문자열에서 원하는 문자 다른것으로 대체
//        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
//
//        let postDatabaseRef = Database.database().reference().child("\(safeEmail)").child("Contents")
//        postDatabaseRef.observeSingleEvent(of: .value) { (snapshot) in
//            guard let postInfo = snapshot.value as? [String: Any] else { return }
//            let data = try! JSONSerialization.data(withJSONObject: Array(postInfo.values), options: [])
//            print("data--->\(data)")
//            let decoder = JSONDecoder()
//            let fetchInfos = try! decoder.decode([fetchInfo].self, from: data)  // data -> [fetchInfo].self 형태로 디코딩
//            self.fetchInfos = fetchInfos
////            self.tableView.reloadData()
//            print("snapshot--->\(data), \(fetchInfos)")
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setThemeAsDefault()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(#function)
//        print("fetchInfos.count--->\(fetchInfos.count)")
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.row {
//        case 0:
//            print(#function, "fetchInfos--->\(fetchInfos)")
//            let cellIdentifier = String(describing: DetailTableViewCell.self)
//            let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell
//            cell.titleLabel.text = "메모"
//            cell.infoLabel.text = "2020/11/02 (월)"
//            cell.descriptionLabel.text = "영화 의뢰인 속 배우 하정우도 맛있게 흡입한 현지의 맛 가득 담은 베트남 음식점!! 00 이랑 다음에 가야겠다:-)"
//            cell.descriptionLabel.text = fetchInfos[indexPath.row].description
            
//            해결해야하는 부분!
            
//            cell.selectionStyle = .none
//
//            cell.separatorView.isHidden = false
//            return cell
//        case 1:
            let cellIdentifier = String(describing: DetailTableViewCell.self)
            let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell
        cell.titleLabel.text = titleLabel
        cell.infoLabel.text = withFriendsLabel
        cell.descriptionLabel.text = descriptionLabel
//            cell.titleLabel.text = "같이 가고 싶은 사람"
//            cell.infoLabel.text = "총 5명"
//            cell.descriptionLabel.text = "ㅇㅇㅇ / ㅇㅇㅇ / ㅇㅇㅇ / ㅇㅇㅇ / ㅇㅇㅇ"
        
//            cell.selectionStyle = .none
//
//            cell.separatorView.isHidden = true

            return cell
//        default:
//            fatalError("Detail View Controller의 cellForRowAt 메소드에서 엉뚱한 인덱스에 접근하였습니다")
//        }
    }
    
}

extension UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
