//
//  ProfileViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/30/25.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var edit: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var segmentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "حسابى"
        navigationItem.titleView?.tintColor = .white
        view.backgroundColor = UIColor.systemBlue
        
        contentView.layer.cornerRadius = 30
//        contentView.layer.masksToBounds = true
        segmentView.layer.cornerRadius = 10
        segmentView.layer.masksToBounds = true
        
        
        doctorImage.layer.cornerRadius = doctorImage.bounds.width / 2
        doctorImage.clipsToBounds = true
        edit.layer.cornerRadius = edit.bounds.width / 2
        edit.clipsToBounds = true
        edit.layer.borderWidth = 1
        edit.layer.borderColor = UIColor(hex: "FFFFFF").cgColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.shadowColor = .clear        // أهم واحدة
        appearance.shadowImage = UIImage()     // بعض الأنظمة تحتاجها

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.title = "حسابى"
    }

}
