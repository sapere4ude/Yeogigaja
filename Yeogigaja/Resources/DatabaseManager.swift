//
//  DatabaseManager.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/10/06.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import Foundation
import FirebaseDatabase


/// 실시간 Firebase 데이터베이스에 데이터를 읽고 씀

final class DatabaseManager {
    public static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

extension DatabaseManager {
    
    public func postingContent(with post: post, completion: @escaping (Bool) -> Void) {
        database.child(post.userName).setValue([
            "postingContent": post.postingContent
        ])
    }
}
