//
//  entryTableViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/05.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import Parchment
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
//import FirebaseUI

class TableViewController: UIViewController {
    
    //MARK:paging
    let queryOnceCnt:Int = 10
    var currentPage:Int = 0
    let callNextPageBeforeOffset:CGFloat = 150
    var isQuery:Bool = false
    var reachEnd:Bool = false
    var searchText:String = ""
    
    // MARK: - 서버정보를 받기위한 배열, fetchInfo는 구조체로 구현
    var fetchInfos: [fetchInfo] = []
    var postInfo: [String: Any] = [:]
    
    @IBOutlet weak var entryTableView: UITableView!
    
    let cellIdentifier = "mainPageTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        entryTableView.separatorStyle = .none
        entryTableView.delegate = self
        entryTableView.dataSource = self
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userEmail = Auth.auth().currentUser?.email
        var safeEmail = userEmail!.replacingOccurrences(of: ".", with: "-") // 문자열에서 원하는 문자 다른것으로 대체
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        
        DispatchQueue.main.async {
            let postDatabaseRef = Database.database().reference().child("\(safeEmail)").child("Contents")
            postDatabaseRef.observeSingleEvent(of: .value) { (snapshot) in
                guard let postInfo = snapshot.value as? [[String: Any]] else { return }
                print("\(postInfo)")
                let data = try! JSONSerialization.data(withJSONObject: postInfo, options: [])
                let decoder = JSONDecoder()
                let fetchInfos = try! decoder.decode([fetchInfo].self, from: data)  // data -> [fetchInfo].self 형태로 디코딩
                self.fetchInfos = fetchInfos
                self.entryTableView.reloadData()
                print("snapshot--->\(data), \(fetchInfos)")
            }
        }
    }
}


//MARK:- tableView extension
extension TableViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = entryTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? tableViewCell else {
            return UITableViewCell()
        }
        cell.entryTitleLabel?.text = fetchInfos[indexPath.row].name
        cell.entryDetailLabel?.text = fetchInfos[indexPath.row].description
        cell.entryAreaLabel?.text = fetchInfos[indexPath.row].location
        
        // Create reference to the file whose metadata we want to retrieve
//        let forestRef = Storage.storage().reference(withPath: fetchInfos[indexPath.row].image ?? "error")
        
//        let qq = Storage.storage().reference().child("photos/-MQQkfUbDYCmX-yDHejI.jpg")
//        print("qq->\(qq)")
        
        let storageRef = Storage.storage().reference().child(fetchInfos[indexPath.row].image ?? "error");
        storageRef.downloadURL { (URL, error) -> Void in
          if (error != nil) {
            // Handle any errors
          } else {
            // Get the download URL for 'images/stars.jpg'
            print(URL!)
            do {
            let data = try Data(contentsOf: URL!)
            cell.entryImageView.image = UIImage(data: data)
            }
            catch {
                print("q")
            }
          }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did selected")
        let sb = UIStoryboard(name: "DetailViewStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "detailView") as? DetailViewController else{ fatalError() }
        vc.descriptionLabel = fetchInfos[indexPath.row].description
        vc.titleLabel = fetchInfos[indexPath.row].location
        vc.withFriendsLabel = fetchInfos[indexPath.row].withFriends
        
        let storageRef = Storage.storage().reference().child(fetchInfos[indexPath.row].image ?? "error");
        storageRef.downloadURL { (URL, error) -> Void in
          if (error != nil) {
            // Handle any errors
          } else {
            // Get the download URL for 'images/stars.jpg'
            print(URL!)
            do {
            let data = try Data(contentsOf: URL!)
            vc.headerImageView.image = UIImage(data: data)
            }
            catch {
                print("q")
            }
          }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
}

struct fetchInfo: Codable {
    let description: String
    let name: String
    let location: String
    let withFriends: String
    let image: String?
}


