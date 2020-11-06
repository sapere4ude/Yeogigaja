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
        
        return cell
    }

}

extension mapViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
