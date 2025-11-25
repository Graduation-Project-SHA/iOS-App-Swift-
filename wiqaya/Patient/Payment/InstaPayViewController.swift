//
//  InstaPayViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/16/25.
//

import UIKit

class InstaPayViewController: UIViewController {

    
    
    
    
    
    
    @IBOutlet weak var myView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myView.layer.cornerRadius = 30
        
        // التأكد من أن maskToBounds غير مفعل حتى يظهر الظل
        myView.layer.masksToBounds = false
        
        // إضافة الظل
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOffset = CGSize(width: 0, height: 5)  // الظل في الأسفل
        myView.layer.shadowRadius = 10  // نصف قطر الظل
        myView.layer.shadowOpacity = 0.3  // شفافية الظل
        
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Pin") as? PinViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Payment") as? PaymentViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
    }
    
}
