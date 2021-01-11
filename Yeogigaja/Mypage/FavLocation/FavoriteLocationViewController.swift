//
//  FavoriteLocationViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FavoriteLocationViewController: UIViewController {
    var selectNumber: Int = 0
    let SeoulLocation = ["종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "종랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구"]
    
    var sendData: [Int] = []
    var dataToServer = [Any]()
    
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        return button
    }()

   // MARK: - 관심지역 서버로 전달
    @objc private func buttonPressed(_ sender: Any) {
        let userEmail = Auth.auth().currentUser?.email
        var safeEmail = userEmail!.replacingOccurrences(of: ".", with: "-") // 문자열에서 원하는 문자 다른것으로 대체
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        dataToServer.removeAll()
        for i in 0 ..< sendData.count {
            dataToServer.append(change(id: sendData[i]))
        }

        print("dataToServer->\(dataToServer)")

        Database.database().reference().child("\(safeEmail)").child("Location").observeSingleEvent(of: .value, with: { snapshot in
            Database.database().reference().child("\(safeEmail)").child("Location").setValue(self.dataToServer)
            print("success")
             }) { (error) in
               print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationCollectionView.allowsMultipleSelection = true
        self.title = "관심 지역"
        self.navigationItem.rightBarButtonItem = self.rightButton
        flowLayoutSetting()
    }
    
    func flowLayoutSetting() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let flowWidth: CGFloat = UIScreen.main.bounds.width / 3.0
        print(flowWidth)
        flowLayout.itemSize = CGSize(width: flowWidth - 20, height: flowWidth - 20)
        self.locationCollectionView.collectionViewLayout = flowLayout
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

        sendData.append(indexPath.row)
        
        print("sendData->\(sendData)")
        
        if (count ?? 0 >= 1){
            makeNavBarRightBtn(count: count)
        }
    }
    
    //셀 1개 이상 선택 시 완료버튼 및 데이터 전송
    func makeNavBarRightBtn(count: Int?){
        self.navigationItem.rightBarButtonItem = self.rightButton
    }
    
    // MARK:- 전달받은 지역번호를 지역이름으로 변환
    func change(id: Int) -> String {
        switch id {
        case 0:
            return "종로구"
        case 1:
            return "중구"
        case 2:
            return "용산구"
        case 3:
            return "성동구"
        case 4:
            return "광진구"
        case 5:
            return "동대문구"
        case 6:
            return "중랑구"
        case 7:
            return "성북구"
        case 8:
            return "강북구"
        case 9:
            return "도봉구"
        case 10:
            return "노원구"
        case 11:
            return "은평구"
        case 12:
            return "서대문구"
        case 13:
            return "마포구"
        case 14:
            return "양천구"
        case 15:
            return "강서구"
        case 16:
            return "구로구"
        case 17:
            return "금천구"
        case 18:
            return "영등포구"
        case 19:
            return "동작구"
        case 20:
            return "관악구"
        case 21:
            return "서초구"
        case 22:
            return "강남구"
        case 23:
            return "송파구"
        default:
            return "error"
        }
    }
    
}
