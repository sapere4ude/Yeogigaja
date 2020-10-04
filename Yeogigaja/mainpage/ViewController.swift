//
//  ViewController.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/09/24.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    //MARK:- properties
    
    @IBOutlet weak var mainTableView: UITableView!
    let cellIdentifier = "mainPageTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for:indexPath)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 170
    }
    
    
}

