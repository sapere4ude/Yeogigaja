//
//  StorageManager.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/10/06.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import Foundation
import FirebaseStorage

/// 파일을 Firebase 스토리지로 가져오고 업로드할 수 있음

final class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    private let storage = Storage.storage().reference()
}
