//
//  WebViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/12/31.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeWebView()
        
    }
    func makeWebView(){
        //url 수정 필요
        guard let url: URL = URL(string:"https://www.notion.so/seoyoung000612/Seo-Young-950b713a18474419a3dffd82c5a8356f") else{ return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

}
