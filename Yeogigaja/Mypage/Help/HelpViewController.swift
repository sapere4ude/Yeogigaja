//
//  HelpViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/11/27.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var helpImage = [
        UIImage(named: "helpSample1"),
        UIImage(named: "helpSample2"),
        UIImage(named: "helpSample3")
    ]
    var timer = Timer()
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        pageController.numberOfPages = helpImage.count
        pageController.currentPage = 0
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImg), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func changeImg(){
        if counter < helpImage.count{
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageController.currentPage = counter
            counter += 1
            
        }else{
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageController.currentPage = counter
        }
    }
    



}

extension HelpViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! helpViewCollectionViewCell
        cell.helpViewimage.image = helpImage[indexPath.row]
        
        return cell
    }
    
    
}
