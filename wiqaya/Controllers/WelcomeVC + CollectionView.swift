//
//  WelcomeVC + CollectionView.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/18/25.
//

import UIKit

extension WelcomVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func initCollectionView() {
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.isPagingEnabled = true
        
        // تسجيل الـ Cell
        let nib = UINib(nibName: "WelcomeCell", bundle: nil)
        myCollection.register(nib, forCellWithReuseIdentifier: "WelcomeCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCell", for: indexPath) as? WelcomeCell else {
            return UICollectionViewCell()
        }
        
        let item = array[indexPath.row]
        
        if indexPath.item == 0 {
            // slideshow أول cell
            let slideshowImages = [
                UIImage(named: "image1")!,
                UIImage(named: "image2")!,
                UIImage(named: "image3")!,
                UIImage(named: "image4")!,
                UIImage(named: "image5")!
            ]
            cell.setSlideshowImages(slideshowImages, title1: item.title1, title2: item.title2)
        } else {
            // Doctor ثابتة
            cell.setStaticImage(item.image, title1: item.title1, title2: item.title2)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
