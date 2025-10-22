//
//  resetPassVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/21/25.
//

import UIKit
class resetPassVC: UIViewController {

    let api = APIService()
    
    var resetToken : String = ""
    @IBOutlet weak var mainPasslbl: UILabel!
    
    @IBOutlet weak var passView: UIView!
    
    
    @IBOutlet weak var txtpass: UITextField!
    
    @IBOutlet weak var showPass: UIButton!
    
    
    
    
    
    @IBOutlet weak var lblPasswordMatches: UILabel!
    
    @IBOutlet weak var markPasswordMatches: UIImageView!
    
    
    
    @IBOutlet weak var lblPassword8letters: UILabel!
    
    @IBOutlet weak var markPassword8letters: UIImageView!
    
    
    
    @IBOutlet weak var lbllblPasswordHasNumbers: UILabel!
    
    @IBOutlet weak var marklblPasswordHasNumbers: UIImageView!
    
    
    
    
    @IBOutlet weak var lblUnallowedSymbols: UILabel!
    
    @IBOutlet weak var markUnallowedSymbols: UIImageView!

    
    @IBOutlet weak var errorRegisterMsg: UILabel!
    
    
    
    
    
    @IBOutlet weak var mainConfirmPass: UILabel!
    
    
    @IBOutlet weak var ConfirmPassView: UIView!
    
    
    @IBOutlet weak var txtConfirmPass: UITextField!
    
    @IBOutlet weak var confirmShowPass: UIButton!
    
    
    
    
    
    var passError : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        errorRegisterMsg.isHidden = true
        passView.isHidden = true
        ConfirmPassView.isHidden = true


        [txtpass,txtConfirmPass].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 1.0
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
        
        txtpass.isSecureTextEntry = true
        txtConfirmPass.isSecureTextEntry = true
        
        showPass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showPass.tintColor = .systemGray3
        
        confirmShowPass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        confirmShowPass.tintColor = .systemGray3
        

        txtpass.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        txtConfirmPass.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)






    }
    @objc func textFieldsChanged(_ sender: UITextField) {
        validatePassword()
    }
    
    private func validatePassword() {
        passError = false
        
        let password = txtpass.text ?? ""
        let confirmPassword = txtConfirmPass.text ?? ""
        
        // الألوان
        let green = UIColor(named: "AppGreen") ?? .systemGreen
        let red = UIColor(named: "AppRed") ?? .systemRed
        
        
        // الشرط 1: تطابق كلمتي المرور
        if confirmPassword.isEmpty {
            lblPasswordMatches.textColor = .systemGray3
            markPasswordMatches.tintColor = .systemGray3
        } else {
            let passwordsMatch = !password.isEmpty && (password == confirmPassword)
            lblPasswordMatches.textColor = passwordsMatch ? green : red
            markPasswordMatches.tintColor = passwordsMatch ? green : red
            markPasswordMatches.image = passwordsMatch
            ? UIImage(systemName: "checkmark.circle.fill")
            : UIImage(systemName: "xmark.circle.fill")
            
            if !passwordsMatch { passError = true }
        }
        
        // الشرط 2: الطول لا يقل عن 8
        let has8Letters = password.count >= 8
        lblPassword8letters.textColor = has8Letters ? green : red
        markPassword8letters.tintColor = has8Letters ? green : red
        markPassword8letters.image = has8Letters
        ? UIImage(systemName: "checkmark.circle.fill")
        : UIImage(systemName: "xmark.circle.fill")
        if !has8Letters { passError = true }

        // 🔹 الشرط 3: يحتوي على رقم + حرف كبير + حرف صغير
        let hasNumbers = password.rangeOfCharacter(from: .decimalDigits) != nil
        let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasLowercase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasStrongMix = hasNumbers && hasUppercase && hasLowercase
        
        lbllblPasswordHasNumbers.textColor = hasStrongMix ? green : red
        marklblPasswordHasNumbers.tintColor = hasStrongMix ? green : red
        marklblPasswordHasNumbers.image = hasStrongMix
        ? UIImage(systemName: "checkmark.circle.fill")
        : UIImage(systemName: "xmark.circle.fill")
        
        if !hasStrongMix { passError = true }
        
        
        // الشرط 4: يجب أن تحتوي كلمة المرور على رمز خاص
        let specialCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+=[]{}|\\:;\"'<>,.?/~`")
        let containsSpecial = password.rangeOfCharacter(from: specialCharacters) != nil
        
        lblUnallowedSymbols.textColor = containsSpecial ? green : red
        markUnallowedSymbols.tintColor = containsSpecial ? green : red
        markUnallowedSymbols.image = containsSpecial
        ? UIImage(systemName: "checkmark.circle.fill")
        : UIImage(systemName: "xmark.circle.fill")
        
        if !containsSpecial { passError = true }

    }
    
    @IBAction func resetPassButton(_ sender: Any) {
        resetPlaceholdersAndBorders()
        
        var hasEmptyField = false
        
        // ✅ التحقق من الحقول الفارغة
        if txtpass.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtpass, placeholder: "من فضلك ادخل كلمة السر هنا..")
            hasEmptyField = true
        }
        if txtConfirmPass.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtConfirmPass, placeholder: "من فضلك اعد كتابة كلمة السر هنا..")
            hasEmptyField = true
        }
        if hasEmptyField { return }
        
        // ✅ التحقق من الشروط الخاصة بكلمة السر (مثلاً الطول والرموز)
        if !passError {
            // ✅ إعداد القيم
            let token = resetToken   // المفروض تكون جاية من الصفحة السابقة
            let pass = txtConfirmPass.text ?? ""
            
            // ✅ استدعاء الـ API
            api.resetPassword(resetToken: token, newPassword: pass) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let message):
                        print("✅ \(message)")
                        
                        // ✅ إظهار شاشة تسجيل الدخول بعد النجاح
                        
                        // أو ممكن تعمل تنقل كامل:
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Success") as? SuccessVC {
                            loginVC.titlelbl = "تم تغيير كلمة السر بنجاح"
                            loginVC.suptitlelbl = ""
                            loginVC.msglbl = "يمكنك التسجيل الآن باستخدام البريد الإلكتروني الذي تم استخدامه في التسجيل"
                            loginVC.modalPresentationStyle = .fullScreen
                            self.present(loginVC, animated: true)
                        }
                         
                        
                    case .failure(let error):
                        // 🟥 لو حصل خطأ من السيرفر
                        self.errorRegisterMsg.isHidden = false
                        self.errorRegisterMsg.text = error.message?.first ?? "Something went wrong."
                        print("❌ Reset password error: \(error.message?.first ?? "")")
                    }
                }
            }
            
        } else {
            // 🟥 لو كلمة السر فيها مشكلة في الشروط
            
            if lblPasswordMatches.textColor == .systemRed || markPasswordMatches.tintColor == .systemRed {
                shake(textField: txtpass)
            }
            
            if lblPassword8letters.textColor == .systemRed || markPassword8letters.tintColor == .systemRed {
                shake(textField: txtConfirmPass)
            }
            
            if lbllblPasswordHasNumbers.textColor == .systemRed || marklblPasswordHasNumbers.tintColor == .systemRed {
                shake(textField: txtpass)
            }
            
            if lblUnallowedSymbols.textColor == .systemRed || markUnallowedSymbols.tintColor == .systemRed {
                shake(textField: txtpass)
            }
            
            // 🔔 اهتزاز بسيط كتنبيه عام
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }

//    showPassRegister showPassConfirmPassRegister
    
    @IBAction func showPassRegister(_ sender: UIButton) {
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
        let wasFirstResponder = txtpass.isFirstResponder
        let existingText = txtpass.text
        
        // تبديل حالة الإخفاء
        txtpass.isSecureTextEntry.toggle()
        
        // إعادة النص بدون مسحه
        txtpass.text = existingText
        if wasFirstResponder {
            txtpass.becomeFirstResponder()
        }
        
        // تحديث الأيقونة
        //        let mycolor = UIColor(red: 55/255, green: 132/255, blue: 100/255, alpha: 1.0)
        let isHidden = txtpass.isSecureTextEntry
        let imageName = isHidden ? "eye.slash" : "eye"
        let iconColor: UIColor = isHidden ? .systemGray3 : .link
        let image = UIImage(systemName: imageName)?.withTintColor(iconColor, renderingMode: .alwaysOriginal)
        sender.setImage(image, for: .normal)

    }
    
    
    
    @IBAction func showPassConfirmPassRegister(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.15) {
                sender.transform = .identity
            }
        })
        
        // 👁️ تبديل حالة الإخفاء مع الحفاظ على المؤشر
        let currentText = txtConfirmPass.text
        let isFirstResponder = txtConfirmPass.isFirstResponder
        
        txtConfirmPass.resignFirstResponder() // لازم علشان منع الجليتش
        txtConfirmPass.isSecureTextEntry.toggle()
        txtConfirmPass.text = currentText
        
        
        // 🖼️ تحديث الأيقونة
        let isHidden = txtConfirmPass.isSecureTextEntry
        let imageName = isHidden ? "eye.slash" : "eye"
        let iconColor: UIColor = isHidden ? .systemGray3 : .link
        let image = UIImage(systemName: imageName)?.withTintColor(iconColor, renderingMode: .alwaysOriginal)
        sender.setImage(image, for: .normal)

    }
    

}
// MARK: - UITextFieldDelegate
extension resetPassVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        mainPasslbl.isHidden = false
        mainConfirmPass.isHidden = false
        
        
        
        
        passView.isHidden = true
        ConfirmPassView.isHidden = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            mainPasslbl.isHidden = true
            passView.isHidden = false
        case 2:
            mainConfirmPass.isHidden = true
            ConfirmPassView.isHidden = false
        default:
            break
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

// MARK: - Helper Methods
extension resetPassVC {
    private func markAsEmpty(textField: UITextField, placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.red]
        )
        textField.layer.borderColor = UIColor.red.cgColor
        shake(textField: textField)
    }
    
    private func resetPlaceholdersAndBorders() {
        txtpass.attributedPlaceholder = NSAttributedString(string: "Pass Register")
        txtConfirmPass.attributedPlaceholder = NSAttributedString(string: "Confirm PassRegiste")
        [txtpass,txtConfirmPass].forEach {
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
    private func shake(view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.4
        animation.values = [-10, 10, -8, 8, -5, 5, 0]
        view.layer.add(animation, forKey: "shake")
    }
    
}
