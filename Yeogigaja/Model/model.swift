//
//  model.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

// MARK: 글 입력할 때 얻게되는 정보. 이를 Firebase로 전달

struct WritePage: Codable {
    var id: String
    var name: String
    var location: String
    var tag: String
    var withFriends: String
    var description: String
    var sentDate: Date
}

struct WritePageCollection {
    enum WritePageCollectionType {
        case nearest, highRatings, realtimeReview
    }

    var datas: [WritePage]
    var type: WritePageCollectionType

    init(datas: [WritePage], type: WritePageCollectionType) {
        self.datas = datas
        self.type = type
    }
}

struct Profile: Codable {
    // let email: String
    let name: String
}

// MARK: YGPageViewController에서 YGMenuBar와 PageViewController의 연동을 위해 사용하는 데이터 구조

struct Page {
    var name: String
    var viewController: UIViewController

    init(name: String, viewController: UIViewController) {
        self.name = name
        self.viewController = viewController
    }
}

struct PageCollection {
    var pages = [Page]()
    var selectedPageIndex: Int = 0
}
