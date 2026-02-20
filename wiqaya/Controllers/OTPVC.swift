//
//  OTPVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/17/25.
//

//
//  OTPVC.swift
//  wiqaya
//

import UIKit
import IQKeyboardManagerSwift

class OTPVC: UIViewController {
    
    // MARK: - Variables
    let api = APIService()
    var email: String = ""
    var countdownTimer: Timer?
    var remainingSeconds = 30
    
    // MARK: - Outlets
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var mainPhoneNumber: UILabel!
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var txtOtp: UITextField!
    @IBOutlet weak var reSend: UIButton!
    @IBOutlet weak var lblReSend: UILabel!
    @IBOutlet weak var labelresend: UILabel!
    @IBOutlet weak var msgError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msgError.isHidden = true
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [OTPVC.self]
        
        txtPhone.text = email
        
        [txtPhone, txtOtp].forEach {
            $0?.delegate = self
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
        
        phoneView.isHidden = true
        showResendUIAndStartCountdown()
    }
    
    // MARK: - Done Button
    @IBAction func doneButton(_ sender: Any) {
        msgError.isHidden = true
        
        guard
            let email = txtPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !email.isEmpty,
            let otp = txtOtp.text,
            !otp.isEmpty
        else {
            msgError.isHidden = false
            msgError.text = "من فضلك أدخل البريد الإلكتروني والكود"
            return
        }
        
        api.verifyResetCode(email: email, code: otp) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let resetVC = storyboard.instantiateViewController(withIdentifier: "ResetPassword") as? resetPassVC {
                        resetVC.email = email
                        resetVC.otp = otp
                        resetVC.modalPresentationStyle = .fullScreen
                        self.present(resetVC, animated: true)
                    }
                    
                case .failure(let error):
                    self.msgError.isHidden = false
                    self.msgError.text = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Resend
    @IBAction func reSendButton(_ sender: Any) {
        reSend.isEnabled = false
        remainingSeconds = 30
        startCountdown()
        
        api.requestPasswordReset(email: txtPhone.text ?? "") { _ in }
    }
    
    // MARK: - Countdown
    private func showResendUIAndStartCountdown() {
        reSend.isEnabled = false
        remainingSeconds = 30
        startCountdown()
    }
    
    private func startCountdown() {
        countdownTimer?.invalidate()
        lblCounter.text = "\(remainingSeconds)ث"
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.remainingSeconds -= 1
            self.lblCounter.text = "\(self.remainingSeconds)ث"
            
            if self.remainingSeconds <= 0 {
                timer.invalidate()
                self.reSend.isEnabled = true
            }
        }
    }
}

extension OTPVC: UITextFieldDelegate {}
