//
//  FavoriteLocationViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class FavoriteLocationViewController: UIViewController {
    var selectNumber: Int = 0
    let SeoulLocation = ["종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "종랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구"]
    
    @IBOutlet weak var locationCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationCollectionView.allowsMultipleSelection = true
    }
    

}

extension FavoriteLocationViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
        //서울 자치구 갯수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteLocationCollectionViewCell", for: indexPath) as! FavoriteLocationCollectionViewCell
        makeCircle(cell: cell)
        cell.locationLabel.text = SeoulLocation[indexPath.row]
        return cell
    }
    //cell 이미지를 원형으로
    func makeCircle(cell: FavoriteLocationCollectionViewCell){
        cell.locationView.layer.cornerRadius = cell.locationView.frame.height / 2
        cell.locationView.layer.borderWidth = 1
        cell.locationView.layer.borderColor = CGColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        cell.locationView.clipsToBounds = true
    }
    
    //셀 선택시 뷰 및 라벨 색 변화
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let count = locationCollectionView.indexPathsForSelectedItems?.count
        
        //count 갯수 제한, 선택가능한지 여부에 대한 bool 형 반환
        if (count ?? 0 >= 5){
            return false
        }else{
            return true
        }
    }
    
    func alertMaxSelectItem(cell: FavoriteLocationCollectionViewCell){
        let alert = UIAlertController(title: "경고", message: "지역 선택 갯수를 초과하였습니다.", preferredStyle: UIAlertController.Style.alert)
        
        let oKAlert = UIAlertAction(title: "확인", style: .default)
        alert.addAction(oKAlert)
        self.present(alert, animated: true) {
            cell.locationView.backgroundColor = UIColor.white
            cell.isSelected = false
            print(cell.isSelected)
        }
    }
}
