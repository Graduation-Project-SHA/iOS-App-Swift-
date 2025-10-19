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
        array.append(WelcomeItem(image: UIImage(named: "image12")!, title1: "أحجز معادك مع الدكتور المناسب", title2: "مجموعة من الخبراء في جميع المجالات موجودين في مكان واحد "))
        array.append(WelcomeItem(image: UIImage(named: "Doctor")!, title1: "أحجز معادك مع الدكتور المناسب", title2: "مجموعة من الخبراء في جميع المجالات موجودين في مكان واحد "))
    }
    
    @IBAction func nextButton(_ sender: Any) {
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
