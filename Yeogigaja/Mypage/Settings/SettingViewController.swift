//
//  SettingViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet private weak var SettingTableView: UITableView!
    private let settingTitle: [SettingModel] = [
        SettingModel("회원 정보 수정"),
        SettingModel("로그아웃"),
        SettingModel("회원 탈퇴"),
        SettingModel("이용 약관"),
        SettingModel("개인정보 처리 방침")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SettingTableView.dataSource = self
        self.SettingTableView.delegate = self
        print("didload")
    }

}


//MARK:- extension TableView
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(settingTitle.count)
        return settingTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SettingTableViewCell = SettingTableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        cell.SettingLabel.text = settingTitle[indexPath.row].SettingLabel
        print(settingTitle[indexPath.row].SettingLabel)
        print(cell.SettingLabel.text)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "SettingDetailViewController") else { return }
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            print("else")
        }
    }
    
    
}
