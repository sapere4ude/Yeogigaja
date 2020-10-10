//
//  entryTableViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/05.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import Parchment

class TableViewController: UIViewController {

    
    @IBOutlet weak var entryTableView: UITableView!
    
    let cellIdentifier = "mainPageTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabbar()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


//MARK:- tableView extension
extension TableViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entryTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for:indexPath)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did selected")
        let sb = UIStoryboard(name: "DetailViewStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "detailView") as? DetailViewController else{fatalError()}
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}


