//
//  entryTableViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/05.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import FirebaseAuth
import Parchment
import UIKit

class TableViewController: UIViewController, CardTableViewCellDelegate {
    @IBOutlet var tableView: UITableView!
    
    // 임시로 만든 더미 데이터
    var dataCollection: [WritePageCollection] = [
        WritePageCollection(datas:
            [WritePage(id: "1", name: "화창한 날씨", location: "와플대학", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "오늘은 날씨가 화창하다 여기는 이런 곳이구나 아하 좋아요~", sentDate: Date()),
             WritePage(id: "2", name: "구름낀 날씨", location: "ㅇㅇ대학교", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "가나다라마바사아자차카타파하 테스트테스트 아아 가나다라마바사아자차카타파하 테스트테스트 아아", sentDate: Date()),
             WritePage(id: "3", name: "화창한 날씨", location: "KMN Place", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "나는 생각이 없다 왜냐면 생각이 없기 때문이다", sentDate: Date()),
             WritePage(id: "4", name: "화창한 날씨", location: "스타벅스 ㅇㅇㅇ점", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "이럴 수도 있고 저럴 수도 있지~", sentDate: Date()),
             WritePage(id: "5", name: "화창한 날씨", location: "아웃백 ㅇㅇㅇ점", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "뭐 어때, 그치?", sentDate: Date())],
            type: .highRatings),
        WritePageCollection(datas:
            [WritePage(id: "1", name: "화창한 날씨", location: "와플대학", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "방금 막 다녀온 와플 대학! 여기 생각보다 맛있어서 좋았어! 다음에 또 오고 싶다 ㅎㅎ", sentDate: Date()),
             WritePage(id: "2", name: "구름낀 날씨", location: "ㅇㅇ대학교", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "가나다라마바사아자차카타파하 테스트테스트 아아 가나다라마바사아자차카타파하 테스트테스트 아아", sentDate: Date()),
             WritePage(id: "3", name: "화창한 날씨", location: "KMN Place", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "나는 생각이 없다 왜냐면 생각이 없기 때문이다", sentDate: Date()),
             WritePage(id: "4", name: "화창한 날씨", location: "스타벅스 ㅇㅇㅇ점", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "이럴 수도 있고 저럴 수도 있지~", sentDate: Date()),
             WritePage(id: "5", name: "화창한 날씨", location: "아웃백 ㅇㅇㅇ점", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "뭐 어때, 그치?", sentDate: Date())],
                            type: .realtimeReview),
        WritePageCollection(datas:
            [WritePage(id: "1", name: "화창한 날씨", location: "와플대학", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "오늘은 날씨가 화창하다 여기는 이런 곳이구나 아하 좋아요~", sentDate: Date()),
             WritePage(id: "2", name: "구름낀 날씨", location: "ㅇㅇ대학교", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "가나다라마바사아자차카타파하 테스트테스트 아아 가나다라마바사아자차카타파하 테스트테스트 아아", sentDate: Date()),
             WritePage(id: "3", name: "화창한 날씨", location: "KMN Place", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "나는 생각이 없다 왜냐면 생각이 없기 때문이다", sentDate: Date()),
             WritePage(id: "4", name: "화창한 날씨", location: "스타벅스 ㅇㅇㅇ점", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "이럴 수도 있고 저럴 수도 있지~", sentDate: Date()),
             WritePage(id: "5", name: "화창한 날씨", location: "아웃백 ㅇㅇㅇ점", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "뭐 어때, 그치?", sentDate: Date())],
            type: .highRatings),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        navigationItem.backButtonTitle = ""
    }
}

// MARK: - tableView extension

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    // Footer를 달기 위해 Section 수를 1로 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Row의 수는 dataCollection의 수로 지정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataCollection[indexPath.row].type {
        case .highRatings:
            let cellIdentifier = "LargeCardTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LargeCardTableViewCell
            
            cell.datas = dataCollection[indexPath.row].datas
            cell.sectionTitle = "높은 평점"
            
            cell.delegate = self
            
            return cell
        case .realtimeReview:
            let cellIdentifier = "LargeCardTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LargeCardTableViewCell
            
            cell.datas = dataCollection[indexPath.row].datas
            cell.sectionTitle = "실시간 리뷰"
            
            cell.delegate = self
            
            return cell
        case .nearest:
            let cellIdentifier = "SmallCardTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SmallCardTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    // 셀 마지막에 나타나는 Footer View 설정
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    // Footer View의 높이 설정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12.0
    }
    
    // TableView 내부의 CollectionViewCell이 선택되었을 때 할 동작 선택. 선택된 셀의 데이터를 인자로 받아옴
    func cardTableViewCell(selectedCollectionView: UICollectionView, selectedData: WritePage, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DetailViewStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "detailView") as? DetailViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
