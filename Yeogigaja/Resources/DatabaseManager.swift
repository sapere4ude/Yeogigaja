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

    private let database = Database.database().reference()

    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}

extension DatabaseManager {
    
    
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
    }
}
