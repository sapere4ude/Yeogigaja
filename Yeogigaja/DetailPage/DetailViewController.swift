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
    var data: WritePage?
    
    //    var fetchInfos: [fetchInfo] = []
//        var titleLabel: String? = ""
//        var descriptionLabel: String? = ""
//        var withFriendsLabel: String? = ""
//        var locationLabel: String? = ""

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setThemeAsDarkTranslucent()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setThemeAsDefault()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cellIdentifier = String(describing: DetailTableViewPostCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewPostCell

            cell.titleLabel.text = data?.name
            cell.descriptionLabel.text = data?.description
            cell.usernameLabel.text = "더미 데이터 (코드에 상수 대입)"

            // NSMutableAttributedString에서 사용할 로케이션 아이콘을 NSTextAttachment를 이용해 설정
            let locationIconImage = UIImage(named: "map")?.withTintColor(cell.locationButton.tintColor, renderingMode: .alwaysTemplate)
            let locationIconTextAttachment = NSTextAttachment()
            locationIconTextAttachment.image = locationIconImage

            let locationIconWidth: Double = 20.0

            let locationIconHeight = locationIconWidth

            // 로케이션 아이콘을 텍스트 라인의 가운데로 정렬 및 아이콘 크기 지정
            locationIconTextAttachment.bounds = CGRect(x: 0.0, y: (Double(cell.locationButton.titleLabel?.font.capHeight ?? 0.0) - locationIconHeight) / 2.0, width: locationIconWidth, height: locationIconHeight)

            // NSMutableAttributedString을 이용하여 텍스트 맨 앞에 로케이션 아이콘을 문자처럼 넣음
            let locationText = NSMutableAttributedString()
            locationText.append(NSAttributedString(attachment: locationIconTextAttachment))
            // \u{200B}는 길이가 없는 문자열이다. 아래의 addAttribute를 이용하기 위해서 넣어주었다.
            locationText.append(NSAttributedString(string: "\u{200B}\(data?.location ?? "장소 데이터 없음")"))

            // 아이콘과 location 문자열 사이에 4만큼 거리 띄어줌
            locationText.addAttribute(.kern, value: 4, range: NSMakeRange(1, 1))
            locationText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(2, data?.location.count ?? 0))
            cell.locationButton.setAttributedTitle(locationText, for: .normal)

            cell.locationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)

            let image = UIImage(named: "user")
            cell.userProfileImageView.image = image
            cell.selectionStyle = .none

            return cell
        default:
            fatalError("Detail View Controller의 cellForRowAt 메소드에서 엉뚱한 인덱스에 접근하였습니다")
        }
    }

    @objc func locationButtonPressed() {
        print("임시로 버튼 기능 추가")
    }
}

extension UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
