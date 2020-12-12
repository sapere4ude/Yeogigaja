//
//  FavoriteLocationViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class FavoriteLocationViewController: UIViewController {

//    @IBOutlet weak var locationView: UIView!
//    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var LoccollectionView: UICollectionView!
    let location = ["종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구", "강동구"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.LoccollectionView.dataSource = self
        self.LoccollectionView.delegate = self
        customLayout()
    }
    
    
    //customizing collectionView layout
    func customLayout(){
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
        flowLayout.minimumLineSpacing = 7
        flowLayout.minimumInteritemSpacing = 5
        
        let halfWidth:CGFloat = UIScreen.main.bounds.width / 3.0
        flowLayout.itemSize = CGSize(width: halfWidth - 10, height: 40)
        self.LoccollectionView.collectionViewLayout = flowLayout
        
    }
    

    @IBAction func touchView(_ sender: UIView) {
        self.view.backgroundColor = UIColor.green
//        self.locationLabel.tintColor = UIColor.black
    }
    
}


//MARK:- collectionView
extension FavoriteLocationViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return location.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : LocCollectionViewCell = LoccollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LocCollectionViewCell
        
        
        cell.locationView.layer.cornerRadius = cell.locationView.frame.size.height/2
        cell.locationView.layer.borderWidth = 1
            cell.locationView.layer.borderColor = UIColor.clear.cgColor
            cell.locationView.clipsToBounds = true

        cell.locationLabel.text = location[indexPath.row]
        
        return cell
    }
    
    
}
