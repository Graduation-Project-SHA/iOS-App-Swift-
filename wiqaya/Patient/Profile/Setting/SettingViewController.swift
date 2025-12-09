//
//  SettingViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/8/25.
//

import UIKit

class SettingViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        navigationItem.title = "الاعدادات"

        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func logOutButton(_ sender: Any) {
        let alert = UIAlertController(
            title: "تسجيل الخروج",
            message: "ستحتاج إلى إدخال اسم المستخدم الخاص بك وكلمة المرور في المرة القادمة.\nهل تريد تسجيل الخروج؟",
            preferredStyle: .alert
        )
        
        // زر تسجيل خروج (أحمر)
        let logoutAction = UIAlertAction(title: "تسجيل خروج", style: .destructive) { _ in
            
            // 👇 هنا تعمل Push للصفحة اللي بعدها
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "Login") as? LogIngVC {
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                self.present(loginVC, animated: true)
            }
        }
        
        // زر إلغاء
        let cancelAction = UIAlertAction(title: "إلغاء", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(logoutAction)
        
        present(alert, animated: true, completion: nil)

    }
    

}
