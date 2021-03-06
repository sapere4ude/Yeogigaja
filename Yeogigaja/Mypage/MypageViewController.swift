//
//  MypageViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/09.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MypageViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let users: String = "users"
    let db = Database.database().reference()
    var profile: [Profile] = []
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var settingTableView: UITableView!
    
    private let cellTitle0 = ["관심지역", "찜한 장소"]
    private let cellTitle1 = ["사용법", "공지사항", "설정"]
    private let cellImg0: [UIImage?] = [UIImage(named: "map"), UIImage(named: "heart")]
    private let cellImg1: [UIImage?] = [UIImage(named:"help"), UIImage(named:"docs"), UIImage(named:"setting")]
    private let sections = ["활동", "정보"]
    
    
    
    @IBAction func touchUpLogout(_ sender: Any) {
        print(#function)
        
        let alert = UIAlertController(title: "로그아웃", message: "정말로 진행하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let progress = UIAlertAction(title: "로그아웃", style: .default, handler: { (UIAlertAction) in
            do {
                try FirebaseAuth.Auth.auth().signOut()
                print("로그아웃 되었습니다")
                let storyboard: UIStoryboard = UIStoryboard(name: "login", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        })
        alert.addAction(cancel)
        alert.addAction(progress)
        self.present(alert, animated: false, completion: nil)
    }
    
    @IBAction func userInfoModify(_ sender: Any) {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: "SettingDetailViewController") as? SettingDetailViewController else {fatalError()}
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        settingTableView.isScrollEnabled = false
        getDataFor()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        makeCircleImg()
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Firebase 연동
    func getDataFor() {
        
        let userEmail = Auth.auth().currentUser?.email
        print("\(userEmail)")
        
        var safeEmail = userEmail!.replacingOccurrences(of: ".", with: "-") // 문자열에서 원하는 문자 다른것으로 대체
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        db.child("\(safeEmail)").observeSingleEvent(of: .value) { snapshot in
            do {
                print(#function)
                print("\(snapshot)")
                
                // JSON 형태로 있는 값들에서 원하는 정보 가져오기
                let value = snapshot.value as? NSDictionary
                let userName = value?["name"] as? String ?? ""
                let userEmail = value?["email"] as? String ?? ""
                
                self.userName?.text = userName
                self.userEmail?.text = userEmail
                
            } catch let error {
                print("--> Error: \(error.localizedDescription)")
            }
        }
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
        self.userImg.layer.cornerRadius = userImg.frame.size.height/2
        self.userImg.layer.borderWidth = 1
        self.userImg.layer.borderColor = UIColor.clear.cgColor
        self.userImg.clipsToBounds = true
    }


}


//MARK:- tableView delegate
extension MypageViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
        guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.textColor = UIColor.black
    }
    
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
        
        //call customizing method
        tableViewCustom(cell: cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let FavLocationSb = UIStoryboard(name: "FavoriteLocation", bundle: nil)
        guard let FavLocationVc = FavLocationSb.instantiateViewController(withIdentifier: "FavoriteLocation") as? FavoriteLocationViewController else{
            return
        }
        
        let FavPlaceSb = UIStoryboard(name: "FavoritePlace", bundle: nil)
        guard let FavPlaceVc = FavPlaceSb.instantiateViewController(withIdentifier: "FavoritePlace") as? FavoritePlaceViewController else{
            return
        }
        
        let HelpSb = UIStoryboard(name: "Help", bundle: nil)
        guard let HelpVc = HelpSb.instantiateViewController(withIdentifier: "Help") as? HelpViewController else{return}
        
        let NotifiSb = UIStoryboard(name: "Notification", bundle: nil)
        guard let NotifiVc = NotifiSb.instantiateViewController(withIdentifier: "Notification") as? NotificationViewController else{return}
        
        let SettingSb = UIStoryboard(name: "Setting", bundle: nil)
        guard let SettingVc = SettingSb.instantiateViewController(withIdentifier: "Setting") as? SettingViewController else{return}
        

        if indexPath.section == 0{
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(FavLocationVc, animated: true)
       
            case 1:
                self.navigationController?.pushViewController(FavPlaceVc, animated: true)
  
            default:
                return
        }
        }
        if indexPath.section == 1{
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(HelpVc, animated: true)
            
            case 1:
                self.navigationController?.pushViewController(NotifiVc, animated: true)
               
            case 2:
                self.navigationController?.pushViewController(SettingVc, animated: true)
                
            default:
         
                return
            }
        }
    }
        

        
    
}
