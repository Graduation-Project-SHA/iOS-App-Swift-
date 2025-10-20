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

    // MARK: - Outlets
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var mainPhoneNumber: UILabel!

    @IBOutlet weak var mainOtpNumper: UILabel!
    
    @IBOutlet weak var txtOtp: UITextField!
    
    @IBOutlet weak var reSend: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [OTPVC.self]

        [txtPhone].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 1.0
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
        phoneView.isHidden = true

        
        
    }
    
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
                case .success(let message):
                    print("✅ Code verified successfully: \(message)")
                    
                    // بعد ما الكود يتحقق بنجاح، تقدر تفتح شاشة تغيير الباسورد مثلاً
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    if let resetVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as? ResetPasswordVC {
//                        resetVC.modalPresentationStyle = .fullScreen
//                        self.present(resetVC, animated: true)
//                    }
                    
                case .failure(let error):
                    print("❌ Verification failed: \(error.localizedDescription)")
                    
                    let alert = UIAlertController(title: "Error", message: "Invalid OTP. Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    
    // MARK: - Back Button Action
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func reSendButton(_ sender: Any) {
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
