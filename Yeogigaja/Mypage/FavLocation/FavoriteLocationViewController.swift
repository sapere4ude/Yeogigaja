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
    
    private var rightButton: UIBarButtonItem = { let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        return button
        
    }()

    @objc private func buttonPressed(_ sender: Any) {
        //data 전송
        print("data send")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationCollectionView.allowsMultipleSelection = true
        self.title = "관심 지역"
    }
    

}

//MARK:-  collcectionView delegate, datasource
extension FavoriteLocationViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
        //서울 자치구 갯수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteLocationCollectionViewCell", for: indexPath) as! FavoriteLocationCollectionViewCell
        makeCircle(cell: cell)
        cellLabelTextSize(cell: cell)
        cell.locationLabel.text = SeoulLocation[indexPath.row]
        return cell
    }
    
    //셀 텍스트 사이즈 자동 조정
    func cellLabelTextSize(cell: FavoriteLocationCollectionViewCell){
        if cell.locationLabel.adjustsFontSizeToFitWidth == false{
            cell.locationLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    //cell 이미지를 원형으로
    func makeCircle(cell: FavoriteLocationCollectionViewCell){
        cell.locationView.layer.cornerRadius = cell.locationView.frame.height / 2
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
    
    //선택된 cell 갯수 확인
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let count = locationCollectionView.indexPathsForSelectedItems?.count
        if (count ?? 0 >= 1){
            makeNavBarRightBtn(count: count)
        }
    }
    
    
    //셀 1개 이상 선택 시 완료버튼 및 데이터 전송
    func makeNavBarRightBtn(count: Int?){
        self.navigationItem.rightBarButtonItem = self.rightButton
    }
    
}
