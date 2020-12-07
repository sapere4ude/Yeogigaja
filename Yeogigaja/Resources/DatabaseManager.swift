//
//  DatabaseManager.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/11/05.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

/// Manager object to read and write data to real time firebase database
final class DatabaseManager {

    /// Shared instance of class
    public static let shared = DatabaseManager()

    /// 데이터베이스에서 데이터를 읽고 쓰기위해 사용하는 프로퍼티
    private let database = Database.database().reference()

    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}

extension DatabaseManager {
    
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
    
    /// 사용자 등록
    /// setValue 코드를 사용하여 지정된 참조에 데이터를 저장하고 해당 경로의 기존 데이터를 모두 바꾼다
    /// observeSingleEventOfType - 한 번 로드된 후 자주 변경되지 않거나 능동적으로 수신 대기할 필요가 없는 데이터에 유용함. ex) 사용자 프로필 로드
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
    
    public func createNewWritePage(with writePage: WritePage, completion: @escaping (Bool) -> Void) {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String,
              let currentName = UserDefaults.standard.value(forKey: "name") as? String else {
                return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        
        let ref = database.child("\(safeEmail)")    // 로그인되는 이메일 -> ref 라는 이름으로 전달
        
        ref.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard var userNode = snapshot.value as? [String: Any] else {
                completion(false)
                print("user not found")
                return
            }
//            let dateString = // 보류
            let writePageId = "writePage_\(writePage.id)"
            let writePageName = "writePage_\(writePage.name)"
            let writePageLocation = "writePage_\(writePage.location)"
            let writePageTags = "writePage_\(writePage.tags)"
            let writePageWithFriends = "writePage_\(writePage.withFriends)"
            let writePageDescription = "writePage_\(writePage.description)"
            let writeSentDate = "writePage_\(writePage.sentDate)"
            
            let newWritePageData: [String: Any] = [
                "id": writePageId,
                "name": writePageName,
                "location": writePageLocation,
                "tags": writePageTags,
                "withFriends": writePageWithFriends,
                "description": writePageDescription,
                "sentDate": writeSentDate,
            ]

            if var conversations = userNode["conversations"] as? [[String: Any]] {
                conversations.append(newWritePageData)
                userNode["conversations"] = conversations
                ref.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                })
            }
            
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
    }
}
