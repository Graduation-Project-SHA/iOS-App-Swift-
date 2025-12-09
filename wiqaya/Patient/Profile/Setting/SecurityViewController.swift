//
//  SecurityViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/8/25.
//

import UIKit

class SecurityViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let backImage = UIImage(systemName: "chevron.backward") { // أو صورتك انت
            let navBar = UINavigationBar.appearance()
            navBar.backIndicatorImage = backImage
            navBar.backIndicatorTransitionMaskImage = backImage
        }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        // نخلي الكنترولر الحالي هو الـ delegate
        navigationController?.interactivePopGestureRecognizer?.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.shadowColor = .clear        // أهم واحدة
        appearance.shadowImage = UIImage()     // بعض الأنظمة تحتاجها
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.title = "الأمان"

        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }



}
