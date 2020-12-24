//
//  HelpViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController, UIScrollViewDelegate {

   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var frame = CGRect.zero
    
    var image: [UIImage?] = [UIImage(named: "helpImg1"),UIImage(named: "help-1"),UIImage(named: "test1"),UIImage(named: "test1"),UIImage(named: "test1"),UIImage(named: "test1"),UIImage(named: "test1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = image.count
        pageControl.currentPage = 0
        scrollView.delegate = self
        settingScroll()
    }
    
    func settingScroll(){
        for index in 0..<image.count{
            //사진을 옆으로 side by side 로 넣기 위해 x 값 조정
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            
            //이미지가 로드되고 스크롤뷰에 로드되도록 frame 사이즈에
            let imgView = UIImageView(frame: frame)
            imgView.image = image[index]
            imgView.contentMode = .scaleAspectFit

            //contentsize 를 스크롤뷰 전체 사이즈로 설정
            self.scrollView.addSubview(imgView)
            scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(image.count)), height: scrollView.frame.size.height)
        }
    }
    
    //page end 되고 다음 페이지로 넘어갈 때
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        
    }
    
}
