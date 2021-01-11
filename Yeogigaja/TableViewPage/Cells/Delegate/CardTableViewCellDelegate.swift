//
//  CardTableViewCellProtocol.swift
//  Yeogigaja
//
//  Created by 김진태 on 2021/01/01.
//  Copyright © 2021 sapere4ude. All rights reserved.
//

import UIKit

// SmallCardTableViewCell과 LargeCardTableViewCell에서 사용할 delegate 정의
protocol CardTableViewCellDelegate {
    func cardTableViewCell(selectedCollectionView: UICollectionView, selectedData: WritePage, didSelectItemAt indexPath: IndexPath)
}
