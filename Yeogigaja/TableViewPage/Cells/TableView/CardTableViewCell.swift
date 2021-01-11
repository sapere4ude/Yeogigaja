//
//  LargeCardCell.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/12/30.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import Cosmos
import UIKit

class CardTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var sectionLabel: UILabel!
    
    // 인자로 받아오는 data들이 저장되는 프로퍼티
    var datas: [WritePage]?
    var sectionTitle: String? {
        didSet {
            guard let sectionTitle = sectionTitle else {
                return
            }
            sectionLabel.text = sectionTitle
        }
    }

    var type: WritePageCollectionType?
    var delegate: CardTableViewCellDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier: String
        if let type = type {
            switch type {
            case .highRatings:
                cellIdentifier = String(describing: HighRatingsCollectionViewCell.self)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HighRatingsCollectionViewCell
                
                // NSMutableAttributedString에서 사용할 로케이션 아이콘을 NSTextAttachment를 이용해 설정
                let locationIconImage = UIImage(named: "mapMarker")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                let locationIconTextAttachment = NSTextAttachment()
                locationIconTextAttachment.image = locationIconImage
                
                let locationIconWidth: Double
                locationIconWidth = Double(cell.subtitleLabel.font.capHeight)
                
                let locationIconHeight = locationIconWidth * 4.0 / 3.0
                
                // 로케이션 아이콘을 텍스트 라인의 가운데로 정렬 및 아이콘 크기 지정
                locationIconTextAttachment.bounds = CGRect(x: 0.0, y: (Double(cell.subtitleLabel.font.capHeight) - locationIconHeight) / 2.0, width: locationIconWidth, height: locationIconHeight)
                
                // NSMutableAttributedString을 이용하여 텍스트 맨 앞에 로케이션 아이콘을 문자처럼 넣음
                let locationText = NSMutableAttributedString()
                locationText.append(NSAttributedString(attachment: locationIconTextAttachment))
                locationText.append(NSAttributedString(string: " \(datas?[indexPath.row].location ?? "장소 데이터 없음")"))
                
                cell.titleLabel.text = datas?[indexPath.row].name ?? ""
                cell.subtitleLabel.attributedText = locationText
                
                cell.layer.cornerRadius = 8.0
                cell.clipsToBounds = true
                
                return cell
            case .nearestPinned:
                cellIdentifier = String(describing: NearestPinnedCollectionViewCell.self)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! NearestPinnedCollectionViewCell
                cell.locationLabel.text = datas?[indexPath.row].location ?? ""
                
                cell.layer.cornerRadius = 8.0
                cell.clipsToBounds = true
                
                return cell
            default:
                break
            }
        }
        cellIdentifier = String(describing: DefaultCardCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DefaultCardCollectionViewCell
        cell.titleLabel.text = datas?[indexPath.row].name ?? ""
        cell.locationLabel.text = datas?[indexPath.row].location ?? ""
        cell.descriptionLabel.text = datas?[indexPath.row].description ?? ""
        
        cell.layer.cornerRadius = 8.0
        cell.clipsToBounds = true
        
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
