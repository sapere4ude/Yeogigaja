//
//  FavoritePlaceViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class FavoritePlaceViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var fetchFavData: [WritePage] = [ WritePage(id: "1", name: "화창한 날씨", location: "서울특별시 강동구 길동 근처에 있는 홈플러스 안에 와플 대학", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "오늘은 날씨가 화창하다 여기는 이런 곳이구나 아하 좋아요~", sentDate: Date()),
     WritePage(id: "2", name: "구름낀 날씨", location: "ㅇㅇ대학교", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "가나다라마바사아자차카타파하 테스트테스트 아아 가나다라마바사아자차카타파하 테스트테스트 아아", sentDate: Date()),
     WritePage(id: "3", name: "화창한 날씨", location: "KMN Place", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "나는 생각이 없다 왜냐면 생각이 없기 때문이다", sentDate: Date()),
     WritePage(id: "4", name: "화창한 날씨", location: "스타벅스 ㅇㅇㅇ점", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "이럴 수도 있고 저럴 수도 있지~", sentDate: Date()),
     WritePage(id: "5", name: "화창한 날씨", location: "아웃백 ㅇㅇㅇ점", tag: "", withFriends: "친구 친구 친구 친구 친구", description: "뭐 어때, 그치?", sentDate: Date())]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        self.title = "찜한 장소"
        
    }
}

//MARK: - tableView delegate, dataSource
extension FavoritePlaceViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchFavData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FavPlaceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FavPlaceTableViewCell", for: indexPath) as? FavPlaceTableViewCell else { return UITableViewCell() }
        cell.FavPlaceName.text = fetchFavData[indexPath.row].name
        cell.FavPlaceLocation.text = fetchFavData[indexPath.row].location
        cell.FavPlaceDescription.text = fetchFavData[indexPath.row].description
        cell.cellView.layer.cornerRadius = 8
        cell.cellView.clipsToBounds = true
        
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DetailViewStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "detailView") as? DetailViewController else { return }
        vc.data = fetchFavData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func tableView(_ tableView: UITableView, willDisplay cell: FavPlaceTableViewCell, forRowAt indexPath: IndexPath) {
//        tableView.backgroundColor = .clear
        print("here")
        
    }
    
}
