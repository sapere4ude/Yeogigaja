//
//  FavoriteLocationViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class FavoriteLocationViewController: UIViewController {

    @IBOutlet weak var LoccollectionView: UICollectionView!
    let location = ["종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구", "강동구"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.LoccollectionView.dataSource = self
        self.LoccollectionView.delegate = self
        // Do any additional setup after loading the view.
        print("loc")
    }


}


//MARK:- collectionView
extension FavoriteLocationViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(location.count)
        return location.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : LocCollectionViewCell = LoccollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LocCollectionViewCell
        
//        cell.Locbtn.imageView?.contentMode = .scaleAspectFit
//        cell.Locbtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cell.Locbtn.setTitle(location[indexPath.row], for: .normal)
        
        return cell
    }
    
    
}
