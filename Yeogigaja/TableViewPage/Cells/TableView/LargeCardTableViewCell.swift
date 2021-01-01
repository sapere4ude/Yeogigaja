//
//  LargeCardCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/12/30.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class LargeCardTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var sectionLabel: UILabel!
    
    //인자로 받아오는 data들이 저장되는 프로퍼티
    var datas: [WritePage]?
    var sectionTitle: String? {
        didSet {
            guard let sectionTitle = sectionTitle else {
                return
            }
            sectionLabel.text = sectionTitle
        }
    }
    var delegate: CardTableViewCellDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "LargeCardCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LargeCardCollectionViewCell
        
        cell.layer.cornerRadius = 8.0
        cell.clipsToBounds = true
        cell.locationLabel.text = datas?[indexPath.row].location ?? ""
        cell.descriptionLabel.text = datas?[indexPath.row].description ?? ""
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = datas?[indexPath.row] else { return }
        delegate?.cardTableViewCell(selectedCollectionView: collectionView, selectedData: data, didSelectItemAt: indexPath)
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
