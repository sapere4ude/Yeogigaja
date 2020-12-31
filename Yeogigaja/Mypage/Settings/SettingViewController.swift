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
        self.SettingTableView.separatorStyle = .none
    }

}


//MARK:- extension TableView
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTitle.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //마지막 셀은 버전정보을 나타내는 셀로 띄움
        if indexPath.row == settingTitle.count {
            guard let cell: VersionSettingTableViewCell = SettingTableView.dequeueReusableCell(withIdentifier: "VersionSettingTableViewCell", for: indexPath) as? VersionSettingTableViewCell else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        } else{
            guard let cell: SettingTableViewCell = SettingTableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            cell.SettingLabel.text = settingTitle[indexPath.row].SettingLabel
            cell.selectionStyle = .none
            return cell
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "SettingDetailViewController") else { return }
        //0번 셀에 대해서만 내비게이션 연결을해준다.
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            if indexPath.row == 1{
                makeAlert(style: UIAlertController.Style.alert, "로그아웃", "로그아웃 하시겠습니까?")
            }
            if indexPath.row == 2{
                makeAlert(style: UIAlertController.Style.alert, "회원탈퇴", "탈퇴하시겠습니까?")
            }
            else{
                print("3,4")
            }
        }
    }
}

extension SettingViewController{
    func makeAlert(style: UIAlertController.Style, _ title: String, _ message: String){
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let YesAction = UIAlertAction(title: "예", style: UIAlertAction.Style.default, handler: {_ in print("yes")})
        let NoAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.cancel, handler: {_ in print("No")})
        alertController.addAction(YesAction)
        alertController.addAction(NoAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
