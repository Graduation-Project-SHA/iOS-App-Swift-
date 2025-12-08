//
//  SettingViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/8/25.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
