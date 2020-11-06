//
//  mapViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/10/09.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class mapViewController: UIViewController {

    @IBOutlet weak var map1: mapView!
    
    
    @IBAction func touch(_ sender: Any) {
        
            let sb = UIStoryboard(name: "local", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "local")
            self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imagePressed(_:)))
        self.map1.addGestureRecognizer(gesture)
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden=false
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    @objc func tapped(_ gesture: UIGestureRecognizer){
        let sb = UIStoryboard(name: "local", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "local")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func imagePressed(_ gesture: UITapGestureRecognizer)
    {
       print("image pressed \(gesture)")
       let tappedImageVIew = gesture.view as! UIView
       print("image pressed \(tappedImageVIew.tag)")
    }


}
