//
//  CalendarViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/09.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: FSCalendar!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingCalendar()
        
    }
    
    func settingCalendar() {
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.appearance.headerTitleColor = .black
        
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        calendarView.appearance.titleDefaultColor = .black          // 달력의 평일 날짜 색깔
        calendarView.appearance.titleWeekendColor = .red            // 달력의 토,일 날짜 색깔
        calendarView.appearance.headerTitleColor = .systemPink      // 달력의 맨 위의 년도, 월의 색깔
        calendarView.appearance.selectionColor = .red
        calendarView.appearance.weekdayTextColor = .orange          // 달력의 요일 글자 색깔
        calendarView.appearance.borderRadius = 0                    // 선택된 날짜의 모서리 부분
        calendarView.allowsMultipleSelection = true                 // 여러 날짜 선택
        calendarView.swipeToChooseGesture.isEnabled = true
        
        calendarView.delegate = self
        calendarView.dataSource = self
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 날짜 선택 시 콜백 메서드
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        calendar.deselect(date) // 선택된 날짜 색깔 생기는것 없애기
        
        // action sheet title 설정
        let alert = UIAlertController(title: "새 글 쓰기", message: "원하는 내용을 작성하실 수 있습니다.", preferredStyle: UIAlertController.Style.actionSheet)
        
        // 옵션 설정
        let writeAction = UIAlertAction(title: "작성하기", style: .default, handler: {_ in
            
            let vc = UIStoryboard(name: "Write", bundle: nil)
            let controller = vc.instantiateViewController(withIdentifier: "Write")

            controller.modalPresentationStyle = .automatic

            self.present(controller, animated: true, completion: nil)   // 실행은되는데 cancel, save 버튼이 보이지 않은 문제점 해결하기
        })
        let cancelAction = UIAlertAction(title: "취소하기", style: .default, handler: {
            ( alert: UIAlertAction!) -> Void in
        })
        
        alert.addAction(writeAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    // 날짜 선택 해제 시 콜백 메서드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    
    }
    
}
