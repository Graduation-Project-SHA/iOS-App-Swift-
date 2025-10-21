//
//  OTPVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/17/25.
//

import UIKit
import IQKeyboardManagerSwift

class OTPVC: UIViewController {
    
    // MARK: - Variables
    var country: String = ""
    var phoneCode: String = ""
    let api = APIService()
    var email: String = ""
    var name: String = ""
    var countdownTimer: Timer?
    var remainingSeconds = 30
    
    // MARK: - Outlets
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var mainPhoneNumber: UILabel!
    @IBOutlet weak var mainOtpNumper: UILabel!
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var txtOtp: UITextField!
    @IBOutlet weak var reSend: UIButton!
    @IBOutlet weak var lblReSend: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [OTPVC.self]
        txtPhone.text = email
        
        [txtPhone].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 1.0
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
        phoneView.isHidden = true
        
        // ✅ أول ما الصفحة تفتح، يبدأ العد التنازلي لإعادة الإرسال
        showResendUIAndStartCountdown()
    }
    
    // MARK: - Done Button Action
    @IBAction func doneButton(_ sender: Any) {
        resetPlaceholdersAndBorders()
        
        var hasEmptyField = false
        if txtPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtPhone, placeholder: "Please enter your email")
            hasEmptyField = true
        }
        if txtOtp.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtOtp, placeholder: "Please enter your password")
            hasEmptyField = true
        }
        if hasEmptyField { return }
        
        let email = (txtPhone.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let otp = txtOtp.text ?? ""
        
        api.verifyResetCode(email: email, code: otp) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let resetToken):
                    print("✅ Code verified successfully. Token: \(resetToken)")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let resetVC = storyboard.instantiateViewController(withIdentifier: "ResetPassword") as? resetPassVC {
                        resetVC.resetToken = resetToken
                        resetVC.modalPresentationStyle = .fullScreen
                        resetVC.modalTransitionStyle = .crossDissolve
                        self.present(resetVC, animated: true)
                    }
                    
                case .failure(let error):
                    print("❌ Verification failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - إعادة إرسال الكود
    @IBAction func reSendButton(_ sender: Any) {
        print("🔄 إعادة إرسال الكود...")
        
        // ✅ إعادة إظهار عناصر العدّ والزرار
        lblReSend.isHidden = false
        lblCounter.isHidden = false
        reSend.isHidden = false
        
        // ✅ تعطيل الزر مؤقتًا
        reSend.isEnabled = false
        reSend.setTitleColor(.systemGray, for: .normal)
        
        // ✅ إعادة تعيين العداد وتشغيله من جديد
        countdownTimer?.invalidate()
        remainingSeconds = 30
        startCountdown()
        
        // ✅ استدعاء API لإرسال كود جديد
        api.requestPasswordReset(email: email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    print("✅ Password reset request sent successfully: \(message)")
                case .failure(let error):
                    print("❌ Failed to send password reset request: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Countdown Logic
    private func showResendUIAndStartCountdown() {
        lblReSend.isHidden = false
        reSend.isHidden = false
        lblCounter.isHidden = false
        
        reSend.isEnabled = false
        reSend.setTitleColor(.systemGray, for: .normal)
        
        remainingSeconds = 30
        startCountdown()
    }
    
    private func startCountdown() {
        countdownTimer?.invalidate()
        lblCounter.text = "إعادة إرسال خلال \(remainingSeconds)ث"
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.remainingSeconds -= 1
            self.lblCounter.text = "إعادة إرسال خلال \(self.remainingSeconds)ث"
            
            if self.remainingSeconds <= 0 {
                timer.invalidate()
                self.lblCounter.isHidden = true
                self.reSend.isEnabled = true
                self.reSend.setTitleColor(.systemBlue, for: .normal)
            }
        }
    }
    
    // MARK: - Back Button
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension OTPVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        mainPhoneNumber.isHidden = false
        phoneView.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            mainPhoneNumber.isHidden = true
            phoneView.isHidden = false
        default:
            break
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

// MARK: - Helper Methods
extension OTPVC {
    private func markAsEmpty(textField: UITextField, placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.red]
        )
        textField.layer.borderColor = UIColor.red.cgColor
        shake(textField: textField)
    }
    
    private func resetPlaceholdersAndBorders() {
        txtPhone.attributedPlaceholder = NSAttributedString(string: "Phone")
        [txtPhone].forEach {
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
    }
    
    private func shake(textField: UITextField) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.4
        animation.values = [-10, 10, -8, 8, -5, 5, 0]
        textField.layer.add(animation, forKey: "shake")
    }
}
