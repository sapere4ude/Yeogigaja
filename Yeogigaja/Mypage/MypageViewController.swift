//
//  MypageViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/09.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class MypageViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var settingTableView: UITableView!
    let cellTitle = ["관심지역", "다크모드", "사용법", "개발자정보"]
    @IBOutlet weak var modifyInfo: UIView!
    @IBOutlet weak var logOut: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCircleImg()
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        tapGesture()
    }
    @objc func tapModify(_ gesture: UITapGestureRecognizer) {
        print("modify")
        let sb = UIStoryboard(name: "MyInfo", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "myInfo") as? myInfoViewController else{fatalError()}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapLogOut(_ gesture: UITapGestureRecognizer) {
        print("logout")
    }
    // 사용자 이미지 원형으로 만들기
    func makeCircleImg(){
        userImg.layer.cornerRadius = userImg.frame.height/2
        userImg.layer.borderWidth = 1
        userImg.layer.borderColor = UIColor.clear.cgColor
        userImg.clipsToBounds = true
    }


    func tapGesture(){
        let tapModifyGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapModify(_: )))
        self.modifyInfo.addGestureRecognizer(tapModifyGesture)
        let logOutGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapLogOut(_: )))
        self.logOut.addGestureRecognizer(logOutGesture)
    }
    



}

extension MypageViewController:UITableViewDelegate, UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! setttingTableViewCell
        
        cell.titleLabel?.text = cellTitle[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
