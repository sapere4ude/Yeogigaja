//
//  YGTagListView.swift
//  Yeogigaja
//
//  Created by 김진태 on 2021/01/12.
//  Copyright © 2021 sapere4ude. All rights reserved.
//

import TagListView

class YGTagListView: TagListView {    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTagListView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTagListView()
    }
    
    func setupTagListView() {
        self.cornerRadius = 8
        self.borderWidth = 1
        self.borderColor = UIColor.darkGray
        self.textColor = UIColor.darkGray
        self.textFont = UIFont.systemFont(ofSize: 15)
        self.tagBackgroundColor = UIColor.white
        self.paddingX = 8.0
        self.paddingY = 4.0
    }
}
