//
//  CheckingScreenViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/6/25.
//

import UIKit

class CheckingScreenViewController: UIViewController {

    
    @IBOutlet weak var firstLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var lblFirst: UILabel!
    
    
    @IBOutlet weak var secondLoading: UIActivityIndicatorView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var lblSecond: UILabel!
    
    @IBOutlet weak var next1: UIButton!
    
    var flag: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLoading.startAnimating()
        firstLoading.isHidden = false
        next1.alpha = 0.45
        // Start second loading
        secondLoading.startAnimating()
        secondLoading.isHidden = false

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.next1.alpha = 1
            self.flag = true
            
            
            self.firstLoading.stopAnimating()
            self.firstLoading.isHidden = true
            self.firstImage.image = UIImage(systemName: "checkmark.circle.fill")
            self.firstImage.tintColor = UIColor(hex: "00B312")
            self.firstImage.alpha = 1
            
            self.secondLoading.stopAnimating()
            self.secondLoading.isHidden = true
            self.secondImage.image = UIImage(systemName: "checkmark.circle.fill")
            self.secondImage.tintColor = UIColor(hex: "00B312")
            self.secondImage.alpha = 1

            self.lblFirst.textColor = UIColor(hex: "#1E1E1E")
            self.lblSecond.textColor = UIColor(hex: "#1E1E1E")

        }

    }
    
    @IBAction func nextButton(_ sender: Any) {
        if flag {
            let storyboard = UIStoryboard(name: "Doctor", bundle: nil)
            
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "HomeDoctorTabBar") as? HomeDoctorTabBarViewController {
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: true)
            }
        } else {
            lblFirst.textColor = .red
            lblSecond.textColor = .red
        }
    }
    

}
