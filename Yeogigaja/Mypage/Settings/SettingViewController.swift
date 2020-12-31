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
    let settingTitle: [SettingModel] = [
        SettingModel("회원 정보 수정"),
        SettingModel("로그아웃"),
        SettingModel("회원 탈퇴"),
        SettingModel("이용 약관"),
        SettingModel("개인정보 처리 방침"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
