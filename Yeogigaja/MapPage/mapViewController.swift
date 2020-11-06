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
    var padding: CGFloat = 10
    var numberOfCol: CGFloat = 2
    
    
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
                cell.backgroundView = UIView()
                let gradientLayer = CAGradientLayer()
                gradientLayer.frame.size = cell.frame.size
                gradientLayer.colors = [#colorLiteral(red: 0.9338900447, green: 0.4315618277, blue: 0.2564975619, alpha: 1),#colorLiteral(red: 0.8518816233, green: 0.1738803983, blue: 0.01849062555, alpha: 1)]
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                cell.backgroundView?.layer.addSublayer(gradientLayer)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
        let sb = UIStoryboard(name: "locationView", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "location") as? locationViewController else{fatalError()}
        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)
    }
    
    

}

extension mapViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
