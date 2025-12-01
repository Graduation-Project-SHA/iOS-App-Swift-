//
//  EmergencyViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/23/25.
//

import UIKit

class EmergencyViewController: UIViewController {

    
    @IBOutlet weak var emergencyActivateView: UIView!
    
    
    @IBOutlet weak var generalInformationView: UIView!
    
    @IBOutlet weak var callConfirm: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emergencyActivateView.layer.cornerRadius = 15
        emergencyActivateView.layer.masksToBounds = true
        emergencyActivateView.layer.borderWidth = 1
        emergencyActivateView.layer.borderColor = UIColor(hex: "E5E5E5").cgColor

        generalInformationView.layer.cornerRadius = 15
        generalInformationView.layer.masksToBounds = true
        generalInformationView.layer.borderWidth = 1
        generalInformationView.layer.borderColor = UIColor(hex: "E5E5E5").cgColor

        
        callConfirm.tintColor = UIColor(hex: "E7000B")

    }
    
    @IBAction func callConfirmButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "CallConfirm") as? CallConfirmViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

    }
    @IBAction func backbutton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "HospitalDetails") as? HospitalDetailsViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
        
    }


}
