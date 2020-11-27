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
    private let cellTitle0 = ["관심지역", "찜한 장소"]
    private let cellTitle1 = ["사용법", "공지사항", "설정"]
    private let cellImg0: [UIImage?] = [UIImage(named: "map"), UIImage(named: "heart")]
    private let cellImg1: [UIImage?] = [UIImage(named:"help"), UIImage(named:"docs"), UIImage(named:"setting")]
    private let sections = ["활동", "정보"]
    @IBOutlet weak var modifyInfo: UIView!
    @IBOutlet weak var logOut: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCircleImg()
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        tapGesture()
        self.settingTableView.sectionIndexBackgroundColor = .clear
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:-methods
    
    //modify Info method
    @objc func tapModify(_ gesture: UITapGestureRecognizer) {
        print("modify")
        let sb = UIStoryboard(name: "MyInfo", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "myInfo") as? myInfoViewController else{fatalError()}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //logOut method
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


    //gesture 전체를 관리하는 메서드
    func tapGesture(){
        let tapModifyGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapModify(_: )))
        self.modifyInfo.addGestureRecognizer(tapModifyGesture)
        let logOutGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapLogOut(_: )))
        self.logOut.addGestureRecognizer(logOutGesture)
    }
    



}


//MARK:- tableView delegate
extension MypageViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }

    func tableViewCustom(cell: UITableViewCell){
        self.settingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cellTitle0.count
        case 1:
            return cellTitle1.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! setttingTableViewCell
        
        let text = indexPath.section == 0 ? cellTitle0[indexPath.row] : cellTitle1[indexPath.row]
        let img = indexPath.section == 0 ? cellImg0[indexPath.row] : cellImg1[indexPath.row]
        cell.titleLabel?.text = text
        cell.IconImg?.image = img
        tableViewCustom(cell: cell)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        return 0
//    }
    
}
