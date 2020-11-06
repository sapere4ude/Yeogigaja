//
//  mapViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/09.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class mapViewController: UIViewController,  UICollectionViewDataSource {

    
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    var padding: CGFloat = 20
    var numberOfCol: CGFloat = 3
    
    
    @IBOutlet weak var localCollectionView: UICollectionView!
    
    override func viewDidLayoutSubviews() {
        print("layout subview")
        super.viewDidLayoutSubviews()
        localCollectionView.contentInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        if let flowLayout = localCollectionView.collectionViewLayout as? UICollectionViewLayout {
            cellWidth = (localCollectionView.frame.width - (numberOfCol + 1)*padding)/numberOfCol
            cellHeight = 100
            
        }else{
            print(fatalError())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = localCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let list = ["은평구", "마포구", "서대문구", "종로구", "중구", "용산구", "성북구", "강북구", "도봉구", "노원구", "중랑구", "광진구", "동대문구", "성동구", "강서구", "양천구", "구로구", "영등포구", "동작구", "금천구", "관악구", "서초구", "강남구", "송파구", "강동구"]
        cell.name.text = list[indexPath.row]
        
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let sb = UIStoryboard(name: "locationView", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "location") as? locationViewController else{fatalError()}
        self.navigationController?.pushViewController(vc, animated: true)

    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    

}

extension mapViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
