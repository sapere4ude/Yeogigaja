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
    let id: String
    let name: String
    let location: String
    let tag: String
    let withFriends: String
    let description: String
}
