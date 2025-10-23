//
//  ForgotPasswordVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/17/25.
//

import UIKit
import IQKeyboardManagerSwift
class ForgotPasswordVC: UIViewController {
    let api = APIService()

    
    @IBOutlet weak var mainEmailLabel: UILabel!

    @IBOutlet weak var send: UIButton!

    
    @IBOutlet weak var cancel: UIButton!
    
    
    @IBOutlet weak var EmailView: UIView!

    
    @IBOutlet weak var textEmail: UITextField!

    
    @IBOutlet weak var resetPass: UILabel!
    
    
    @IBOutlet weak var msgError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msgError.isHidden = true
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [ForgotPasswordVC.self]

        resetPass.font = .boldSystemFont(ofSize: 25)
        
        [textEmail].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 1.0
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
        EmailView.isHidden = true



    }
    
    
    @IBAction func resetPassButton(_ sender: Any) {
        resetPlaceholdersAndBorders()
        
        var hasEmptyField = false
        if textEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: textEmail, placeholder: "Please enter your email")
            hasEmptyField = true
        }
        if hasEmptyField { return }

        let email = (textEmail.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        api.requestPasswordReset(email: email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    print("✅ Password reset request sent successfully: \(message)")
                    if "\(message)" == "User with this email does not exist" {
                        self.msgError.isHidden = false
                        self.msgError.text = "البريد الإلكتروني غير مُسجل، تأكد من صحته و حاول مرة اخرى."
                    }else{
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let otpVC = storyboard.instantiateViewController(withIdentifier: "OTP") as? OTPVC {
                            otpVC.email = self.textEmail.text ?? ""
                            //                            otpVC.VC = false
                            otpVC.modalPresentationStyle = .fullScreen
                            otpVC.modalTransitionStyle = .crossDissolve
                            self.present(otpVC, animated: true)
                        }
                    }
                    
                case .failure(let error):
                    print("❌ Failed to send password reset request: \(error.localizedDescription)")
                    let alert = UIAlertController(
                        title: "حدث مشكله في ارسال رمز التحقق يرجى المحاولة مرة أخرى.",
                        message: "\(error.localizedDescription)",
                        preferredStyle: .alert
                    )
                    
                    let okAction = UIAlertAction(title: "حسناً", style: .default, handler: nil)
                    alert.addAction(okAction)
                    
                    self.present(alert, animated: true, completion: nil)

                }
            }
        }

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    
}

// MARK: - UITextFieldDelegate
extension ForgotPasswordVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        mainEmailLabel.isHidden = false
        EmailView.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            mainEmailLabel.isHidden = true
            EmailView.isHidden = false
        default:
            break
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

// MARK: - Helper Methods
extension ForgotPasswordVC {
    private func markAsEmpty(textField: UITextField, placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.red]
        )
        textField.layer.borderColor = UIColor.red.cgColor
        shake(textField: textField)
    }
    
    private func resetPlaceholdersAndBorders() {
        textEmail.attributedPlaceholder = NSAttributedString(string: "Email")
        [textEmail].forEach {
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
