//
//  model.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import Foundation

// MARK: 글 입력할 때 얻게되는 정보. 이를 Firebase로 전달
struct WritePage {
    var id: String
    var name: String
    var location: String
    var tags: [String]
    var withFriends: String
    var description: String
    var sentDate: Date
}
