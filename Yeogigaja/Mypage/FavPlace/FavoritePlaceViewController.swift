//
//  FavoritePlaceViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class FavoritePlaceViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
extension FavoritePlaceViewController: UITableViewDelegate, UITableViewDataSource {
    
}
