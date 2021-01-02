//
//  model.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

// MARK: - 글 입력할 때 얻게되는 정보. 이를 Firebase로 전달
struct WritePage: Codable {
    var id: String
    var name: String
    var location: String
    var tag: String
    var withFriends: String
    var description: String
    var sentDate: Date
}

struct Profile: Codable {
    //let email: String
    let name: String
}

// MARK:- YGPageViewController에서 YGMenuBar와 PageViewController의 연동을 위해 사용하는 데이터 구조
struct Page {
    var name: String
    var viewController: UIViewController
    
    init(name: String, viewController: UIViewController) {
        self.name = name
        self.viewController = viewController
    }
}

struct PageCollection {
    var pages: [Page] = [Page]()
    var selectedPageIndex: Int = 0
}

//// Mark
////["종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구"]
//enum InterestLocationType: Int, CaseIterable {
//    case 종로구 = 0
//    case 중구
//    case 용산구
//    case 성동구
//    case 광진구
//    case 동대문구
//    case 중랑구
//    case 성북구
//    case 강북구
//    case 도봉구
//    case 노원구
//    case 은평구
//    case 서대문구
//    case 마포구
//    case 양천구
//    case 강서구
//    case 구로구
//    case 금천구
//    case 영등포구
//    case 동작구
//    case 관악구
//    case 서초구
//    case 강남구
//    case 송파구
//    case 강동구
//
////    init?(id : Int) {
////        switch id {
////            case 0: self = .종로구
////            case 1: self = .중구
////            case 2: self = .용산구
////            case 3: self = .성동구
////            case 4: self = .광진구
////            case 5: self = .동대문구
////            case 6: self = .중랑구
////            case 7: self = .성북구
////            case 8: self = .강북구
////            case 9: self = .도봉구
////            case 10: self = .노원구
////            case 11: self = .은평구
////            case 12: self = .서대문구
////            case 13: self = .마포구
////            case 14: self = .양천구
////            case 15: self = .강서구
////            case 16: self = .구로구
////            case 17: self = .금천구
////            case 18: self = .영등포구
////            case 19: self = .동작구
////            case 20: self = .관악구
////            case 21: self = .서초구
////            case 22: self = .강남구
////            case 23: self = .송파구
////            case 24: self = .강동구
////
////            default: return nil
////            }
////        }
//}
//
//struct ChangeLocation {
//    func change(id: Int) -> String {
//        switch id {
//        case 0:
//            return "종로구"
//        case 1:
//            return "중구"
//        case 2:
//            return "용산구"
//        case 3:
//            return "성동구"
//        case 4:
//            return "광진구"
//        case 5:
//            return "동대문구"
//        case 6:
//            return "중랑구"
//        case 7:
//            return "성북구"
//        case 8:
//            return "강북구"
//        case 9:
//            return "도봉구"
//        case 10:
//            return "노원구"
//        case 11:
//            return "은평구"
//        case 12:
//            return "서대문구"
//        case 13:
//            return "마포구"
//        case 14:
//            return "양천구"
//        case 15:
//            return "강서구"
//        case 16:
//            return "구로구"
//        case 17:
//            return "금천구"
//        case 18:
//            return "영등포구"
//        case 19:
//            return "동작구"
//        case 20:
//            return "관악구"
//        case 21:
//            return "서초구"
//        case 22:
//            return "강남구"
//        case 23:
//            return "송파구"
//        default:
//            return "error"
//        }
//    }
//}
