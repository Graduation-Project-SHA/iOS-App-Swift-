//
//  PinViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/17/25.
//

import UIKit
import LocalAuthentication

class PinViewController: UIViewController {
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var lockView: UIView!
    @IBOutlet weak var successView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        successView.isHidden = true
        successView.layer.cornerRadius = 20
        lockView.layer.cornerRadius = lockView.bounds.height / 2
        
    }
    
    @IBAction func faceIDButton(_ sender: Any) {
        let context = LAContext()
        var error: NSError? = nil
        
        context.localizedFallbackTitle = "استخدام رمز الدخول"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Unlock using your passcode"
            
            context.evaluatePolicy(.deviceOwnerAuthentication,
                                   localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    guard success, authError == nil else {
                        let alert = UIAlertController(
                            title: "Failed to Authenticate",
                            message: "Please try again.",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        return
                    }
                    
                    self.lockImage.image = UIImage(systemName: "lock.open")
                    self.successView.isHidden = false
                    self.myView.alpha = 0.3
                    self.myView.backgroundColor = UIColor(hex: "333333")
                    
                }
            }
        } else {
            let alert = UIAlertController(
                title: "FaceID Not Available",
                message: "This device does not support FaceID.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func goToMyAppointmentButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Appointment") as? AppointmentViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

    }
    
    
//    @IBAction func doneButton(_ sender: Any) {
//        let context = LAContext()
//        var error: NSError? = nil
//        
//        context.localizedFallbackTitle = "استخدام رمز الدخول"
//        
//        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
//            let reason = "Unlock using your passcode"
//            
//            context.evaluatePolicy(.deviceOwnerAuthentication,
//                                   localizedReason: reason) { success, authError in
//                DispatchQueue.main.async {
//                    guard success, authError == nil else {
//                        let alert = UIAlertController(
//                            title: "Failed to Authenticate",
//                            message: "Please try again.",
//                            preferredStyle: .alert
//                        )
//                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//                        self.present(alert, animated: true)
//                        return
//                    }
//                    
//                    self.lockImage.image = UIImage(systemName: "lock.open")
//                    self.successView.isHidden = false
//                    self.view.alpha = 0.5
//                    self.txtPass.text = ""
//                }
//            }
//        } else {
//            let alert = UIAlertController(
//                title: "FaceID Not Available",
//                message: "This device does not support FaceID.",
//                preferredStyle: .alert
//            )
//            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//            self.present(alert, animated: true)
//        }
//    }
}
