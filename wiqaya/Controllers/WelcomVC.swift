//
//  WelcomVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/18/25.
//

import UIKit

class WelcomVC: UIViewController {
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    
    @IBOutlet weak var next1: UIButton!
    
    
    @IBOutlet weak var skip: UIButton!
    
    var array = [WelcomeItem] ()


    override func viewDidLoad() {
        super.viewDidLoad()
//        labelView
        
                     
        initData()
        initCollectionView()
    }
    
    func initData() {
        array.append(WelcomeItem(image: UIImage(named: "image1")!, title1: "أحجز معادك مع الدكتور المناسب", title2: "مجموعة من الخبراء في جميع المجالات موجودين في مكان واحد "))
        array.append(WelcomeItem(image: UIImage(named: "Doctor")!, title1: "أحجز معادك مع الدكتور المناسب", title2: "مجموعة من الخبراء في جميع المجالات موجودين في مكان واحد "))
    }
    
    @IBAction func nextButton(_ sender: Any) {
        // نحصل على indexPath الحالي للـ visible cell
        let visibleIndexPaths = myCollection.indexPathsForVisibleItems
        guard let currentIndexPath = visibleIndexPaths.first else { return }
        
        let nextItem = currentIndexPath.item + 1
        
        if nextItem < array.count {
            // التحرك للـ cell التالية
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            myCollection.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        } else {
            // لو وصلنا للـ آخر cell ننفذ الانتقال للـ Login
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let otpVC = storyboard.instantiateViewController(withIdentifier: "Login") as? LogIngVC {
                otpVC.modalPresentationStyle = .fullScreen
                otpVC.modalTransitionStyle = .crossDissolve
                present(otpVC, animated: true)
            }
        }

    }
    
    @IBAction func skipButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let otpVC = storyboard.instantiateViewController(withIdentifier: "Login") as? LogIngVC {
            otpVC.modalPresentationStyle = .fullScreen
            otpVC.modalTransitionStyle = .crossDissolve // أنيميشن لطيف (اختياري)
            present(otpVC, animated: true)
        }

    }
    
}
