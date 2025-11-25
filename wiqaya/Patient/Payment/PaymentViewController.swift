//
//  PaymentViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/16/25.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var cardPay: UIButton!
    
    
    @IBOutlet weak var instaPay: UIButton!
    
    var cardPaySelected : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cardPayButton(_ sender: Any) {
        cardPaySelected = true
        cardPay.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        cardPay.tintColor = UIColor(hex: "254EDB")
        instaPay.setImage(UIImage(systemName: "circle"), for: .normal)
        instaPay.tintColor = UIColor(hex: "C1C2C4")
        
    }
    
    
    @IBAction func instaPayButton(_ sender: Any) {
        cardPaySelected = false

        instaPay.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        instaPay.tintColor = UIColor(hex: "254EDB")

        cardPay.setImage(UIImage(systemName: "circle"), for: .normal)
        cardPay.tintColor = UIColor(hex: "C1C2C4")

    }
    
    @IBAction func editButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Booking") as? BookingViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

    }
    
    @IBAction func payButton(_ sender: Any) {
        if cardPaySelected {
            let storyboard = UIStoryboard(name: "Patient", bundle: nil)
            
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "MasterCard") as? MasterCardViewController {
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: false)
            }

        }else {
            let storyboard = UIStoryboard(name: "Patient", bundle: nil)
            
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "InstaPay") as? InstaPayViewController {
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: false)
            }

        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Booking") as? BookingViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
    }
    

}
