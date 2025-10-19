//
//  LogIngVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/17/25.
//

import UIKit

class LogIngVC: UIViewController {
    
    var iAmDoctor: Bool = false
    var country: String = ""
    var phoneCode: String = ""
    

    // MARK: - Login as User and Doctor View

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

    
    
    
    // MARK: - Register as User View

    @IBOutlet weak var myScrollView: UIScrollView!
    

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var txtFirstName: UITextField!
    
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var txtLastName: UITextField!
    
    
    
    @IBOutlet weak var mainEmailRegister: UILabel!
    
    @IBOutlet weak var EmailRegisterView: UIView!
    
    @IBOutlet weak var txtEmailRegister: UITextField!
    
    @IBOutlet weak var CheckMarkForEmail: UIImageView!
    
    
    
    @IBOutlet weak var mainPhoneRegister: UILabel!
    
    @IBOutlet weak var phoneRegisterView: UIView!
    
    @IBOutlet weak var txtPhoneRegister: UITextField!
    @IBOutlet weak var pullbutton: UIButton!
    
    @IBOutlet weak var countryImage: UIImageView!

    
    
    
    @IBOutlet weak var mainDate: UILabel!
    
    @IBOutlet weak var mydatePicker: UIDatePicker!
    
    @IBOutlet weak var imageDate: UIImageView!
    
    

    
    @IBOutlet weak var mainPassRegister: UILabel!
    
    @IBOutlet weak var passRegisterView: UIView!
    
    @IBOutlet weak var txtPassRegister: UITextField!
    
    @IBOutlet weak var showPassRegister: UIButton!
    
    
    
    
    @IBOutlet weak var mainConfirmPassRegister: UILabel!
    
    @IBOutlet weak var ConfirmPassRegisterView: UIView!
    
    @IBOutlet weak var txtConfirmPassRegister: UITextField!
    
    @IBOutlet weak var showPassConfirmPassRegister: UIButton!
    
    
    
    
    @IBOutlet weak var lblPasswordMatches: UILabel!
    
    @IBOutlet weak var markPasswordMatches: UIImageView!
    
    
    
    @IBOutlet weak var lblPassword8letters: UILabel!
    
    @IBOutlet weak var markPassword8letters: UIImageView!
    
    
    
    @IBOutlet weak var lbllblPasswordHasNumbers: UILabel!
    
    @IBOutlet weak var marklblPasswordHasNumbers: UIImageView!
    
    
    
    
    @IBOutlet weak var lblUnallowedSymbols: UILabel!
    
    @IBOutlet weak var markUnallowedSymbols: UIImageView!
    
    
    
    

    
    
    let gradient = GradientManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        myScrollView.isHidden = true
        CheckMarkForEmail.isHidden = true
        authView.layer.cornerRadius = 20
        
        // إعداد مظهر صورة العلم
        countryImage.contentMode = .scaleAspectFit
        countryImage.clipsToBounds = true
        
        // إعداد الزرار
        pullbutton.setTitle("", for: .normal) // نخليه من غير نص
        pullbutton.showsMenuAsPrimaryAction = true
        
        // تهيئة القائمة المنسدلة
        configurePullDownButton()

        
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
        
        
        [textEmail, textPass, txtFirstName,txtLastName,txtEmailRegister,txtPhoneRegister,txtPassRegister,txtConfirmPassRegister].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 1.0
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
        
        textPass.isSecureTextEntry = true
        txtPassRegister.isSecureTextEntry = true
        txtConfirmPassRegister.isSecureTextEntry = true
        
        showPass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showPass.tintColor = .systemGray3
        
        showPassRegister.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showPassRegister.tintColor = .systemGray3
        showPassConfirmPassRegister.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showPassConfirmPassRegister.tintColor = .systemGray3
        
        
        
        
        
        
        
        
        
        EmailView.isHidden = true
        PassView.isHidden = true
        firstNameView.isHidden = true
        lastNameView.isHidden = true
        EmailRegisterView.isHidden = true
        phoneRegisterView.isHidden = true
        passRegisterView.isHidden = true
        ConfirmPassRegisterView.isHidden = true
        
        
        mydatePicker.layer.borderWidth = 0.5
        mydatePicker.layer.borderColor = UIColor.lightGray.cgColor
        mydatePicker.layer.cornerRadius = 10
        mydatePicker.layer.masksToBounds = true
        
        txtPassRegister.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        txtConfirmPassRegister.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)

        iAmDoctor = false
        normalUser.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        doctor.backgroundColor = .clear

    }
    @objc func textFieldsChanged(_ sender: UITextField) {
        validatePassword()
    }
        
    private func validatePassword() {
        let password = txtPassRegister.text ?? ""
        let confirmPassword = txtConfirmPassRegister.text ?? ""
        
        // الألوان
        let green = UIColor(named: "AppGreen") ?? .systemGreen
        let red = UIColor(named: "AppRed") ?? .systemRed
        
        // الشرط 1: تطابق كلمتي المرور
        if confirmPassword.isEmpty {
            // المستخدم لسه ما كتبش في خانة التأكيد => خليه باللون الرمادي أو أخفي التلوين
            lblPasswordMatches.textColor = .systemGray3
            markPasswordMatches.tintColor = .systemGray3
        } else {
            // المستخدم كتب فعلاً => افحص التطابق
            let passwordsMatch = !password.isEmpty && (password == confirmPassword)
            lblPasswordMatches.textColor = passwordsMatch ? green : red
            markPasswordMatches.tintColor = passwordsMatch ? green : red
        }

        // الشرط 2: الطول لا يقل عن 8
        let has8Letters = password.count >= 8
        lblPassword8letters.textColor = has8Letters ? green : red
        markPassword8letters.tintColor = has8Letters ? green : red
        
        // الشرط 3: يحتوي على أرقام
        let hasNumbers = password.rangeOfCharacter(from: .decimalDigits) != nil
        lbllblPasswordHasNumbers.textColor = hasNumbers ? green : red
        marklblPasswordHasNumbers.tintColor = hasNumbers ? green : red
        
        // الشرط 4: الرموز غير المسموح بها
        let unallowedCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+=[]{}|\\:;\"'<>,.?/~`")
        let containsUnallowed = password.rangeOfCharacter(from: unallowedCharacters) != nil
        lblUnallowedSymbols.textColor = containsUnallowed ? red : green
        markUnallowedSymbols.tintColor = containsUnallowed ? red : green
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // استدعاء الميثود لتطبيق التدرج على خلفية الـ View
        gradient.applySmoothBlueGradient(to: self.view, lightRatio: 0.04, midRatio: 0.09, darkRatio: 0.90)
    }

    // MARK: - Configure DropDown Menu
    func configurePullDownButton() {
        // الإجراءات لكل دولة
        let saudiAction = UIAction(title: "Saudi Arabia") { _ in
            self.handleSelection(country: "Saudi Arabia")
        }
        
        let egyptAction = UIAction(title: "Egypt") { _ in
            self.handleSelection(country: "Egypt")
        }
        
        let uaeAction = UIAction(title: "United Arab Emirates") { _ in
            self.handleSelection(country: "United Arab Emirates")
        }
        
        // إنشاء القائمة
        let menu = UIMenu(title: "Choose your country", children: [saudiAction, egyptAction, uaeAction])
        
        // تعيين القائمة للزر
        pullbutton.menu = menu
        pullbutton.showsMenuAsPrimaryAction = true
    }
    
    // MARK: - Handle Selection
    func handleSelection(country: String) {
        self.country = country
        selectPhoneCode()
        
        // تحديث placeholder بناءً على الدولة
        txtPhoneRegister.placeholder = phoneCode
        
        print("Selected Country: \(country), Phone Code: \(phoneCode)")
    }
    
    // MARK: - Assign Country Data
    func selectPhoneCode() {
        switch country {
        case "Saudi Arabia":
            phoneCode = "+966 5 1234 5678"
            countryImage.image = UIImage(named: "Saudi")
            
        case "Egypt":
            phoneCode = "+20 11 1234 5678"
            countryImage.image = UIImage(named: "Egypt")
            
        case "United Arab Emirates":
            phoneCode = "+971 50 123 4567"
            countryImage.image = UIImage(named: "Emirates")
            
        default:
            phoneCode = ""
            countryImage.image = nil
        }
    }
    

    
    
    
    
    
    
    @IBAction func normalUserButton(_ sender: UIButton) {
        iAmDoctor = false

        normalUser.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        doctor.backgroundColor = .clear
        print("normalUserButton")

    }
    
    @IBAction func doctorButton(_ sender: UIButton) {
        iAmDoctor = true
        myScrollView.isHidden = true

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
            myScrollView.isHidden = true
            logInView.isHidden = false

        } else if sender.selectedSegmentIndex == 0 {
            
            print("🆕 إنشاء حساب")
            
            if iAmDoctor {
                logInView.isHidden = true
                myScrollView.isHidden = true

            }else if !iAmDoctor{
                logInView.isHidden = true
                myScrollView.isHidden = false

            }else{
                logInView.isHidden = true
                myScrollView.isHidden = true
            }
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
    //showPassRegister showPassConfirmPassRegister

    @IBAction func showPassRegisterButton(_ sender: UIButton) {
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
        let currentText = txtPassRegister.text
        let isFirstResponder = txtPassRegister.isFirstResponder
        
        txtPassRegister.resignFirstResponder() // لازم علشان منع الجليتش
        txtPassRegister.isSecureTextEntry.toggle()
        txtPassRegister.text = currentText
        
        
        // 🖼️ تحديث الأيقونة
        let isHidden = txtPassRegister.isSecureTextEntry
        let imageName = isHidden ? "eye.slash" : "eye"
        let iconColor: UIColor = isHidden ? .systemGray3 : .link
        let image = UIImage(systemName: imageName)?.withTintColor(iconColor, renderingMode: .alwaysOriginal)
        sender.setImage(image, for: .normal)
    }
    
    
    @IBAction func showPassConfirmPassRegisterButton(_ sender: UIButton) {
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
        let currentText = txtConfirmPassRegister.text
        let isFirstResponder = txtConfirmPassRegister.isFirstResponder
        
        txtConfirmPassRegister.resignFirstResponder() // لازم علشان منع الجليتش
        txtConfirmPassRegister.isSecureTextEntry.toggle()
        txtConfirmPassRegister.text = currentText
        
        
        // 🖼️ تحديث الأيقونة
        let isHidden = txtConfirmPassRegister.isSecureTextEntry
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
        
//        if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
//            tabBarVC.modalPresentationStyle = .fullScreen
//            present(tabBarVC, animated: true)
//        }

    }
    
    // MARK: - Register as User action
    
    @IBAction func dateButton(_ sender: Any) {
        
    }
    
    
    @IBAction func createAccButton(_ sender: Any) {
        resetPlaceholdersAndBorders()

        var hasEmptyField = false

        if txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtFirstName, placeholder: "من فضلك ادخل اسمك الاول هنا..")
            hasEmptyField = true
        }
        if txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtLastName, placeholder: "من فضلك ادخل اسمك الاخير هنا..")
            hasEmptyField = true
        }
        if txtEmailRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtEmailRegister, placeholder: "من فضلك ادخل بريدك الإلكتروني هنا..")
            hasEmptyField = true
        }
        if txtPhoneRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtPhoneRegister, placeholder: "من فضلك ادخل رقم هاتفك هنا..")
            hasEmptyField = true
        }
        if txtPassRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtPassRegister, placeholder: "من فضلك ادخل رقم كلمة السر هنا..")
            hasEmptyField = true
        }
        if txtConfirmPassRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtConfirmPassRegister, placeholder: "من فضلك اعد كتابة كلمة السر هنا..")
            hasEmptyField = true
        }
        if hasEmptyField { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let otpVC = storyboard.instantiateViewController(withIdentifier: "OTP") as? OTPVC {
            otpVC.modalPresentationStyle = .fullScreen
            otpVC.modalTransitionStyle = .crossDissolve // أنيميشن لطيف (اختياري)
            present(otpVC, animated: true)
        }

    }
    
    
    
}

// MARK: - UITextFieldDelegate
extension LogIngVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        mainEmailLabel.isHidden = false
        mainPassLabel.isHidden = false
        firstName.isHidden = false
        lastName.isHidden = false
        mainEmailRegister.isHidden = false
        mainPhoneRegister.isHidden = false
        mainPassRegister.isHidden = false
        mainConfirmPassRegister.isHidden = false
        
        
        
        
        EmailView.isHidden = true
        PassView.isHidden = true
        firstNameView.isHidden = true
        lastNameView.isHidden = true
        EmailRegisterView.isHidden = true
        phoneRegisterView.isHidden = true
        passRegisterView.isHidden = true
        ConfirmPassRegisterView.isHidden = true

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
        case 3:
            firstName.isHidden = true
            firstNameView.isHidden = false
        case 4:
            lastName.isHidden = true
            lastNameView.isHidden = false
        case 5:
            mainEmailRegister.isHidden = true
            EmailRegisterView.isHidden = false
        case 6:
            mainPhoneRegister.isHidden = true
            phoneRegisterView.isHidden = false

        case 7:
            mainPassRegister.isHidden = true
            passRegisterView.isHidden = false
        case 8:
            mainConfirmPassRegister.isHidden = true
            ConfirmPassRegisterView.isHidden = false
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
        txtFirstName.attributedPlaceholder = NSAttributedString(string: "First Name")
        txtLastName.attributedPlaceholder = NSAttributedString(string: "Last Name")
        txtEmailRegister.attributedPlaceholder = NSAttributedString(string: "Email Register")
        txtPhoneRegister.attributedPlaceholder = NSAttributedString(string: "Phone Register")
        txtPassRegister.attributedPlaceholder = NSAttributedString(string: "Pass Register")
        txtConfirmPassRegister.attributedPlaceholder = NSAttributedString(string: "Confirm PassRegiste")
        [textEmail, textPass,txtFirstName,txtLastName,txtEmailRegister,txtPhoneRegister,txtPassRegister,txtConfirmPassRegister].forEach {
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
