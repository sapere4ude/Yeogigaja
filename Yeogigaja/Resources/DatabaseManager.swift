//
//  DatabaseManager.swift
//  Yeogigaja
//
<<<<<<< HEAD
//  Created by sapere4ude on 2020/10/06.
=======
//  Created by sapere4ude on 2020/11/05.
>>>>>>> Login
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import Foundation
<<<<<<< HEAD
import FirebaseDatabase


/// 실시간 Firebase 데이터베이스에 데이터를 읽고 씀

final class DatabaseManager {
    public static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
=======
import FirebaseAuth
import FirebaseDatabase

/// Manager object to read and write data to real time firebase database
final class DatabaseManager {

    /// Shared instance of class
    public static let shared = DatabaseManager()

    private let database = Database.database().reference()

    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
>>>>>>> Login
    
}

extension DatabaseManager {
    
<<<<<<< HEAD
    public func postingContent(with post: post, completion: @escaping (Bool) -> Void) {
        database.child(post.userName).setValue([
            "postingContent": post.postingContent
        ])
=======
    // 중복 유저 확인코드 32-49
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {

        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        
        // observeSingleEventOfType (데이터 읽기) -> 추가된 이벤트 콜백이 한 번 트리거된 후에 다시 트리거되지 않는다. 이 방법은 한 번 로드된 후 자주 변경되지 않거나 능동적으로 수신 대기할 필요가 없는 데이터에 유용하다.
        // escaping closure 이기 때문에 { snapshot in } 부분은 결과가 모두 들어온 뒤에 실행된다.
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? [String: Any] != nil else {
                completion(false)
                return
            }

            completion(true)
        })
    }
    
    // 사용자 등록
    public func insertUser(with user: YeogigajaAppUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "name" : user.name
        ], withCompletionBlock: { [weak self] error, _ in
            
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("데이터베이스 읽기/쓰기 실패")
                completion(false)
                return
            }
            strongSelf.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                if var userCollection = snapshot.value as? [[String : String]] {
                    let newElemnet = [
                        "name" : user.name,
                        "email" : user.safeEmail
                    ]
                    userCollection.append(newElemnet)
                    
                    strongSelf.database.child("users").setValue(userCollection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        
                        completion(true)
                    })
                }
                else {
                    // create that array
                    let newCollection: [[String: String]] = [
                        [
                            "name": user.name,
                            "email": user.safeEmail
                        ]
                    ]

                    strongSelf.database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }

                        completion(true)
                    })
                }
            })
        })
    }
}

struct YeogigajaAppUser {
    let name: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-") // 문자열에서 원하는 문자 다른것으로 대체
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
>>>>>>> Login
    }
}
