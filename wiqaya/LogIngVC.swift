//
//  LogIngVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/17/25.
//

import UIKit

class LogIngVC: UIViewController {
    
    var iAmDoctor: Bool = false
    
    @IBOutlet weak var logo: UILabel!
    @IBOutlet weak var lblStartNow: UILabel!
    @IBOutlet weak var lblMarketing: UILabel!
    @IBOutlet weak var authView: UIView!
    @IBOutlet weak var logInView: UIView!
    
    @IBOutlet weak var normalUser: UIButton!
    @IBOutlet weak var doctor: UIButton!
    @IBOutlet weak var segmentLogInAndSignUP: UISegmentedControl!
    
    
    
    
    
    @IBOutlet weak var mainEmailLabel: UILabel!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var rememberMe: UIButton!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var mainPassLabel: UILabel!
    @IBOutlet weak var PassView: UIView!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPass: UITextField!
    @IBOutlet weak var showPass: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authView.layer.cornerRadius = 20
//        if var config = forgotPassword.configuration {
//            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
//                var outgoing = incoming
//                outgoing.font = UIFont.systemFont(ofSize: 12)
//                return outgoing
//            }
//            forgotPassword.configuration = config
//        }

        // تخصيص الـ Segmented Control
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        segmentLogInAndSignUP.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentLogInAndSignUP.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        // الشكل الافتراضي للأزرار
        setupButtonStyle(button: normalUser)
        setupButtonStyle(button: doctor)
        
        
        [textEmail, textPass].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 1.0
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
        
        textPass.isSecureTextEntry = true
        
        showPass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showPass.tintColor = .systemGray3
        
        EmailView.isHidden = true
        PassView.isHidden = true

    }
    
    @IBAction func normalUserButton(_ sender: UIButton) {
        iAmDoctor = false
        normalUser.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        doctor.backgroundColor = .clear
        print("normalUserButton")

    }
    
    @IBAction func doctorButton(_ sender: UIButton) {
        iAmDoctor = true
        doctor.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        normalUser.backgroundColor = .clear
        print("DoctorButton")
    }
    
    private func setupButtonStyle(button: UIButton) {
        button.configuration = .plain()
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.4).cgColor
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        
    }
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            logInView.isHidden = false

            print("🔑 تسجيل الدخول")
            
        } else if sender.selectedSegmentIndex == 0 {
            
            print("🆕 إنشاء حساب")
            logInView.isHidden = true
            
            
        }

    }
    
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let ForgotPasswordVC = storyboard.instantiateViewController(withIdentifier: "ForgotPassword") as? ForgotPasswordVC {
            
            
            ForgotPasswordVC.modalPresentationStyle = .pageSheet
            
            if let sheet = ForgotPasswordVC.sheetPresentationController {
                // هنا تقدر تتحكم في شكل الـ sheet
                sheet.detents = [.medium(), .large()] // يفتح نص الشاشة أو فلها
                sheet.prefersGrabberVisible = true    // يظهر الخط الصغير اللي فوق للسحب
            }
            
            present(ForgotPasswordVC, animated: true, completion: nil)
        }

    }
    @IBAction func rememberMeButton(_ sender: UIButton) {
        sender.isSelected.toggle() // تغيّر الحالة من selected إلى غير selected والعكس
        
        if sender.isSelected {
            // الحالة مفعّلة
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            print("selected")
        } else {
            // الحالة غير مفعّلة
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            print("non-selected")

        }

    }
    
    @IBAction func showPassButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.15) {
                sender.transform = .identity
            }
        })
        
        // حفظ النص وحالة الفوكس قبل التبديل
        let wasFirstResponder = textPass.isFirstResponder
        let existingText = textPass.text
        
        // تبديل حالة الإخفاء
        textPass.isSecureTextEntry.toggle()
        
        // إعادة النص بدون مسحه
        textPass.text = existingText
        if wasFirstResponder {
            textPass.becomeFirstResponder()
        }
        
        // تحديث الأيقونة
//        let mycolor = UIColor(red: 55/255, green: 132/255, blue: 100/255, alpha: 1.0)
        let isHidden = textPass.isSecureTextEntry
        let imageName = isHidden ? "eye.slash" : "eye"
        let iconColor: UIColor = isHidden ? .systemGray3 : .link
        let image = UIImage(systemName: imageName)?.withTintColor(iconColor, renderingMode: .alwaysOriginal)
        sender.setImage(image, for: .normal)
    }

    
    @IBAction func ClickedOnSignIn(_ sender: Any) {
        resetPlaceholdersAndBorders()
        
        var hasEmptyField = false
        if textEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: textEmail, placeholder: "Please enter your email")
            hasEmptyField = true
        }
        if textPass.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: textPass, placeholder: "Please enter your password")
            hasEmptyField = true
        }
        if hasEmptyField { return }
        
        if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true)
        }

    }
    
}

// MARK: - UITextFieldDelegate
extension LogIngVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        mainEmailLabel.isHidden = false
        mainPassLabel.isHidden = false
        EmailView.isHidden = true
        PassView.isHidden = true
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
        case 2:
            mainPassLabel.isHidden = true
            PassView.isHidden = false
        default:
            break
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

// MARK: - Helper Methods
extension LogIngVC {
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
        textPass.attributedPlaceholder = NSAttributedString(string: "Password")
        [textEmail, textPass].forEach {
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
