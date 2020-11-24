//
//  Write.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/11/20.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var writeTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        
        guard let write = writeTextView.text,
              write.count > 0 else {
            return
        }
        
        let newWrite = Write(content: write)
        Write.dummyWriteList.append(newWrite)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }













}
