//
//  NotificationViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var notifiTableView: UITableView!
    
    // 서버에서 원격으로 보내는 데이터 갯수에 따라 달라지리 변수
    var notifiNumber = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}

//MARK:- tableView delegate
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifiNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: notifiTableViewCell = notifiTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! notifiTableViewCell
        //서버 IndexPath.row 에 따라 다른 내용으로 cell label 을 바꿔야함
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "notification") as? NotifiViewController else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
