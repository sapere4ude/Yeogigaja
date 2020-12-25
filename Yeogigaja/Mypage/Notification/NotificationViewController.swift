//
//  NotificationViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet private weak var NotifiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "공지사항"
        
    }
    
}


//MARK:- TableView Delegate, DataSource
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //data fetching 필요
        
        //data 를 가져와서 offset 갯수를 10개로 지정하고, fetching 한 갯수와 마지막 indexPath 가 된다면, 데이터가져오는 동안 indicator cell 을 띄우기 위한 작업
        if indexPath.row == 9 {
            guard let cell: IndicatorTableViewCell = NotifiTableView.dequeueReusableCell(withIdentifier: "IndicatorTableViewCell", for: indexPath) as? IndicatorTableViewCell else { return UITableViewCell() }
            cell.animationIndicatorView()
            return cell
        }
        
        //이외의 경우에는 공지사항 용 셀을 띄운다.
        guard let cell: NotifiTableViewCell = NotifiTableView.dequeueReusableCell(withIdentifier: "NotifiTableViewCell", for: indexPath) as?NotifiTableViewCell else { return UITableViewCell()}
            
        cell.selectionStyle = .none
        return cell
    }
    
}
