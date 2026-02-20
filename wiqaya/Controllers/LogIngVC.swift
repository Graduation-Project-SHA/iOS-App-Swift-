//
//  LogIngVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/17/25.
//

import UIKit
import CoreLocation
import MapKit
import IQKeyboardManagerSwift

class LogIngVC: UIViewController, CLLocationManagerDelegate {
    
    var iAmDoctor: Bool = false
    var gend: Bool = false
    var isRememberMeSelected = false
    var isLoginSelected = true
    var country: String = ""
    var phoneCode: String = ""
    var myDate : String = ""
    var isDoctor: String = "USER"
    var gender: String = ""
    var userName: String = ""
    var key : String = "+20"
    var formatphone : String = ""
    
    let api = APIService()
    
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
    
    @IBOutlet weak var errorMsg: UILabel!
    
    
    
    
    // MARK: - Register as Doctor View
    var stageNumber : Int = 0
    let complateImages: [UIImage] = [
        UIImage(named: "complate1")!,
        UIImage(named: "complate2")!,
        UIImage(named: "complate3")!
    ]
    
    let locationManager = CLLocationManager()
    
    var currentLat: String?
    var currentLon: String?

    @IBOutlet weak var completionStageImage: UIImageView!
    
    
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var firstStageView: UIView!
    
    
    @IBOutlet weak var secondStageView: UIView!
    
    @IBOutlet weak var backStage: UIButton!
    
    @IBOutlet weak var doctorLocation: MKMapView!
    
    @IBOutlet weak var specializationPull: UIButton!
    
    @IBOutlet weak var specializationLbl: UILabel!
    
    @IBOutlet weak var bioLbl: UITextView!
    
    @IBOutlet weak var practicalExperienceLbl: UITextField!
    
    
    
    
    // MARK: - Register as User View
    
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var topRegisterView: NSLayoutConstraint!
    
    
    
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
    
    
    @IBOutlet weak var man: UIButton!
    
    
    @IBOutlet weak var women: UIButton!
    
    
    
    
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
    
    @IBOutlet weak var errorRegisterMsg: UILabel!
    
    // MARK: - Register as Doctor View
    
    
    
    
    
    
    let gradient = GradientManager()
    let green = UIColor(named: "AppGreen") ?? .systemGreen
    let red = UIColor(named: "AppRed") ?? .systemRed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backStage.isHidden = true
        firstStageView.isHidden = true
        secondStageView.isHidden = true
        
        completionStageImage.isHidden = true
        myScrollView.isHidden = true
        CheckMarkForEmail.isHidden = true
        authView.layer.cornerRadius = 20
        
        
        
        
//اعداد صلاحية الموقع 
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        doctorLocation.showsUserLocation = true

        
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
        completionStageImage.image = complateImages[0]
        
        
        
        
        
        
        errorRegisterMsg.isHidden = true
        errorMsg.isHidden = true
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
        txtEmailRegister.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        
        iAmDoctor = false
        normalUser.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        doctor.backgroundColor = .clear
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkIfUserAlreadyLoggedIn()
        
    }
    
    
    
    
    
    
    
    
    
    func isTokenValid(_ token: String) -> Bool {
        // التوكن بيكون 3 أجزاء مفصولة بـ "."
        let segments = token.split(separator: ".")
        guard segments.count == 3 else { return false }
        
        // الجزء الأوسط هو الـ payload
        let payloadSegment = segments[1]
        
        // نحول الـ Base64 إلى Data
        var base64 = String(payloadSegment)
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        // تكملة padding لو ناقص
        while base64.count % 4 != 0 {
            base64.append("=")
        }
        
        guard let payloadData = Data(base64Encoded: base64),
              let json = try? JSONSerialization.jsonObject(with: payloadData) as? [String: Any],
              let exp = json["exp"] as? TimeInterval else {
            return false
        }
        
        // نحسب الوقت الحالي
        let expirationDate = Date(timeIntervalSince1970: exp)
        return Date() < expirationDate
    }
    
    var passError : Bool = true
    @objc func textFieldsChanged(_ sender: UITextField) {
        validatePassword()
        emailValed()
    }
    
    
    private func emailValed() {
        passError = false
        guard let email = txtEmailRegister.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) else {
            CheckMarkForEmail.isHidden = true
            return
        }
        
        // ✅ صيغة الإيميل الصحيحة باستخدام regex
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let isFormatValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        
        // 🟢 قائمة النطاقات المشهورة
        let allowedDomains = [
            "@gmail.com",
            "@outlook.com",
            "@yahoo.com",
            "@icloud.com",
            "@hotmail.com"
        ]
        
        
        let hasValidDomain = allowedDomains.contains { email.contains($0) }
        let isValid = isFormatValid && hasValidDomain
        
        
        CheckMarkForEmail.isHidden = false
        if isValid {
            CheckMarkForEmail.image = UIImage(systemName: "checkmark.circle.fill")
            CheckMarkForEmail.tintColor = .appGreen
        } else {
            CheckMarkForEmail.image = UIImage(systemName: "xmark.circle.fill")
            CheckMarkForEmail.tintColor = .appRed
            passError = true
        }
    }
    
    
    private func validatePassword() {
        passError = false
        
        let password = txtPassRegister.text ?? ""
        let confirmPassword = txtConfirmPassRegister.text ?? ""
        
        // الألوان
        
        
        // الشرط 1: تطابق كلمتي المرور
        if confirmPassword.isEmpty {
            lblPasswordMatches.textColor = .systemGray3
            markPasswordMatches.tintColor = .systemGray3
        } else {
            let passwordsMatch = !password.isEmpty && (password == confirmPassword)
            lblPasswordMatches.textColor = passwordsMatch ? .appGreen : .appRed
            markPasswordMatches.tintColor = passwordsMatch ? .appGreen : .appRed
            markPasswordMatches.image = passwordsMatch
            ? UIImage(systemName: "checkmark.circle.fill")
            : UIImage(systemName: "xmark.circle.fill")
            
            if !passwordsMatch { passError = true }
        }
        
        // الشرط 2: الطول لا يقل عن 8
        let has8Letters = password.count >= 8
        lblPassword8letters.textColor = has8Letters ? .appGreen : .appRed
        markPassword8letters.tintColor = has8Letters ? .appGreen : .appRed
        markPassword8letters.image = has8Letters
        ? UIImage(systemName: "checkmark.circle.fill")
        : UIImage(systemName: "xmark.circle.fill")
        
        if !has8Letters { passError = true }
        
        
        
        // 🔹 الشرط 3: يحتوي على رقم + حرف كبير + حرف صغير
        let hasNumbers = password.rangeOfCharacter(from: .decimalDigits) != nil
        let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasLowercase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasStrongMix = hasNumbers && hasUppercase && hasLowercase
        
        lbllblPasswordHasNumbers.textColor = hasStrongMix ? .appGreen : .appRed
        marklblPasswordHasNumbers.tintColor = hasStrongMix ? .appGreen : .appRed
        marklblPasswordHasNumbers.image = hasStrongMix
        ? UIImage(systemName: "checkmark.circle.fill")
        : UIImage(systemName: "xmark.circle.fill")
        
        if !hasStrongMix { passError = true }
        
        
        // الشرط 4: يجب أن تحتوي كلمة المرور على رمز خاص
        let specialCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+=[]{}|\\:;\"'<>,.?/~`")
        let containsSpecial = password.rangeOfCharacter(from: specialCharacters) != nil
        
        lblUnallowedSymbols.textColor = containsSpecial ? .appGreen : .appRed
        markUnallowedSymbols.tintColor = containsSpecial ? .appGreen : .appRed
        markUnallowedSymbols.image = containsSpecial
        ? UIImage(systemName: "checkmark.circle.fill")
        : UIImage(systemName: "xmark.circle.fill")
        
        if !containsSpecial { passError = true }
        
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
            key = "+966"
            countryImage.image = UIImage(named: "Saudi")
            
        case "Egypt":
            phoneCode = "+20 11 1234 5678"
            key = "+20"
            
            countryImage.image = UIImage(named: "Egypt")
            
        case "United Arab Emirates":
            phoneCode = "+971 50 123 4567"
            key = "+971"
            
            countryImage.image = UIImage(named: "Emirates")
            
        default:
            phoneCode = ""
            countryImage.image = nil
        }
    }
    func formatPhoneNumber(_ input: String) -> String{
        var trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // لو الرقم بيبدأ بـ "+" خلاص جاهز
        if trimmed.hasPrefix("+") {
            formatphone = trimmed
            return trimmed
        }
        
        // لو الرقم بيبدأ بـ "0" نحذفها
        if trimmed.hasPrefix("0") {
            trimmed.removeFirst()
        }
        
        // نركب الرقم الكامل بمفتاح الدولة
        formatphone = key + trimmed
        print("📱 رقم الهاتف النهائي: \(formatphone)")
        return formatphone
    }
    
    
    
    
    
    
    
    
    @IBAction func normalUserButton(_ sender: UIButton) {
        iAmDoctor = false
        signUp.setTitle("إنشاء حساب", for: .normal)
        backStage.isHidden = true
        completionStageImage.isHidden = true
        topRegisterView.constant = 24
        
        isDoctor = "USER"
        normalUser.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        doctor.backgroundColor = .clear
        print("normalUserButton")
        
    }
    
    @IBAction func doctorButton(_ sender: UIButton) {
        iAmDoctor = true
        signUp.setTitle("التالي", for: .normal)
        
        isDoctor = "DOCTOR"
        if !isLoginSelected{
            completionStageImage.isHidden = false
            topRegisterView.constant = 50
        }
        //        myScrollView.isHidden = true
        
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
            backStage.isHidden = true
            
            isLoginSelected = true
            print("🔑 تسجيل الدخول")
            myScrollView.isHidden = true
            logInView.isHidden = false
            completionStageImage.isHidden = true
            
            
        } else if sender.selectedSegmentIndex == 0 {
            isLoginSelected = false
            
            print("🆕 إنشاء حساب")
            
            if iAmDoctor {
                topRegisterView.constant = 50
                
                logInView.isHidden = true
                completionStageImage.isHidden = false
                myScrollView.isHidden = false
                firstStageView.isHidden = false
                
            }else if !iAmDoctor{
                firstStageView.isHidden = false
                
                completionStageImage.isHidden = true
                topRegisterView.constant = 24
                
                logInView.isHidden = true
                myScrollView.isHidden = false
                
            }else{
                completionStageImage.isHidden = true
                
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
        sender.isSelected.toggle()
        isRememberMeSelected = sender.isSelected // ✅ نخزن الحالة
        
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            print("✅ Remember Me selected")
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            print("🔲 Remember Me unselected")
        }
        
    }
    
    
    @IBAction func menButton(_ sender: Any) {
        
        gend = true
        passError = false
        
        gender = "MALE"
        print(gender)
        man.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        women.backgroundColor = .clear
        
    }
    
    @IBAction func womenButton(_ sender: Any) {
        passError = false
        
        gend = true
        gender = "FEMALE"
        print(gender)
        women.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        man.backgroundColor = .clear
        
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
        
        let email = (textEmail.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let password = textPass.text ?? ""
        
        api.loginUser(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.errorMsg.isHidden = false
                    self.errorMsg.text = "Login successful"
                    self.errorMsg.textColor = .appGreen
                    
                    print("✅ Login successful!")
                    print("🔑 Access token: \(response.data.access_token)")
                    //                    print("👤 name: \(response.data.payload.name)")
                    //                    print("📧 Email: \(response.data.payload.email)")
                    //                    print("🧩 Role: \(response.data.payload.role)")
                    
                    // نحفظ البيانات فقط لو Remember Me مفعّلة
                    if self.isRememberMeSelected {
                        let defaults = UserDefaults.standard
                        defaults.set(response.data.access_token, forKey: "accessToken")
                        defaults.set(response.data.refresh_token, forKey: "refreshToken")
                        //                        defaults.set(response.data.payload.name, forKey: "name")
                        //                        self.userName = response.data.payload.name
                        
                        //                        defaults.set(response.data.payload.email, forKey: "userEmail")
                        //                        defaults.set(response.data.payload.role, forKey: "userRole")
                        
                        print("💾 Tokens saved (Remember Me is ON)")
                    } else {
                        print("Tokens not saved (Remember Me is OFF)")
                    }
                    
                    self.goToHomeScreen(
                        titile: "مرحباً \(self.userName)",
                        supTitle: "تم تسجيل دخولك بنجاح",
                        msg: ""
                    )
                    
                case .failure(let error):
                    self.errorMsg.isHidden = false
                    self.errorMsg.text = error.localizedDescription
                    self.errorMsg.textColor = self.red
                    
                    print("❌ Login error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    private func goToHomeScreen(titile:String , supTitle:String , msg:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeVC = storyboard.instantiateViewController(withIdentifier: "Success") as? SuccessVC {
            homeVC.titlelbl = titile
            homeVC.suptitlelbl = supTitle
            homeVC.msglbl = msg
            homeVC.loadViewIfNeeded() // ضروري قبل التعديل على الـ outlets
            homeVC.done.isHidden = true
            homeVC.modalPresentationStyle = .fullScreen
            homeVC.modalTransitionStyle = .crossDissolve
            self.present(homeVC, animated: true)
        }
    }
    private func checkIfUserAlreadyLoggedIn() {
        let defaults = UserDefaults.standard
        
        if let accessToken = defaults.string(forKey: "accessToken"),
           !accessToken.isEmpty,
           let refreshToken = defaults.string(forKey: "refreshToken"),
           let name = defaults.string(forKey: "name"),
           let email = defaults.string(forKey: "userEmail") {
            
            self.userName = name
            
            if isTokenValid(accessToken) {
                print("🔐 User already logged in with valid token.")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.goToHomeScreen(
                        titile: "مرحباً \(name)",
                        supTitle: "لقد قمت بتسجيل الدخول مسبقاً",
                        msg: ""
                    )
                }
            } else {
                print("⚠️ Token expired — please log in again.")
                defaults.removeObject(forKey: "accessToken")
                defaults.removeObject(forKey: "refreshToken")
                
                let alert = UIAlertController(
                    title: "انتهت الجلسة",
                    message: "يرجى تسجيل الدخول مرة أخرى.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "حسناً", style: .default))
                self.present(alert, animated: true)
            }
            
        } else {
            print("🚫 No saved session found, stay on login screen")
        }
    }
    
    // MARK: - Register as User action
    // MARK: - API for Registr As User
    
    @IBAction func dateButton(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX") // مهم عشان الثبات
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // اختياري
        
        myDate = formatter.string(from: sender.date)
        
        print("DOB:", myDate)  // لازم يطبع 1995-03-12
        
    }
    @IBAction func createAccButton(_ sender: Any) {
        resetPlaceholdersAndBorders()
        
        var hasEmptyField = false
        
        if txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtFirstName, placeholder: "ادخل الاسم الاول")
            hasEmptyField = true
        }
        if txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtLastName, placeholder: "ادخل الاسم الاخير")
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
            markAsEmpty(textField: txtPassRegister, placeholder: "من فضلك ادخل كلمة السر هنا..")
            hasEmptyField = true
        }
        if txtConfirmPassRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            markAsEmpty(textField: txtConfirmPassRegister, placeholder: "من فضلك اعد كتابة كلمة السر هنا..")
            hasEmptyField = true
        }
        if hasEmptyField { return }
        
        guard !myDate.isEmpty else {
            self.errorRegisterMsg.isHidden = false
            
            errorRegisterMsg.text = "من فضلك اختر تاريخ الميلاد أولاً"
            errorRegisterMsg.textColor = .appRed
            return
        }
        guard !gender.isEmpty else {
            self.errorRegisterMsg.isHidden = false
            
            errorRegisterMsg.text = "من فضلك اختر النوع أولاً"
            errorRegisterMsg.textColor = .appRed
            return
        }
        validatePassword()
        
        if iAmDoctor {
            if !passError {
                backStage.isHidden = false
                stageNumber += 1
                firstStageView.isHidden = true
                secondStageView.isHidden = false
                
                completionStageImage.image = complateImages[1]
                
            }else {
                //  اهتز فقط الشروط اللي فيها أخطاء (لونها أحمر)
                
                
                if CheckMarkForEmail.tintColor == .appRed {
                    shake(txtEmailRegister)
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    errorRegisterMsg.text = "البريد الإلكتروني غير صحيح"
                    
                    
                }
                if lblPasswordMatches.textColor == .appRed || markPasswordMatches.tintColor == .appRed {
                    shake(txtConfirmPassRegister)
                    shake(txtPassRegister)
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    txtPassRegister.layer.borderColor = UIColor.red.cgColor
                    txtConfirmPassRegister.layer.borderColor = UIColor.red.cgColor
                    
                    errorRegisterMsg.text = "يجب ان تحقق شروط كلمة السر"
                    
                }
                
                if lblPassword8letters.textColor == .appRed || markPassword8letters.tintColor == .appRed {
                    shake(txtPassRegister)
                    txtPassRegister.layer.borderColor = UIColor.red.cgColor
                    
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    
                    errorRegisterMsg.text = "يجب ان تحقق شروط كلمة السر"
                    
                }
                
                if lbllblPasswordHasNumbers.textColor == .appRed || marklblPasswordHasNumbers.tintColor == .appRed {
                    shake(txtPassRegister)
                    txtPassRegister.layer.borderColor = UIColor.red.cgColor
                    
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    
                    errorRegisterMsg.text = "يجب ان تحقق شروط كلمة السر"
                    
                }
                
                if lblUnallowedSymbols.textColor == .appRed || markUnallowedSymbols.tintColor == .appRed {
                    shake(txtPassRegister)
                    txtPassRegister.layer.borderColor = UIColor.red.cgColor
                    
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    
                    errorRegisterMsg.text = "يجب ان تحقق شروط كلمة السر"
                    
                }
                
                //  ممكن تضيف اهتزاز بسيط للشاشة كتنبيه عام (اختياري)
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
        }else {
            if !passError {
                // ✅ تأكد إن القيم نظيفة وصحيحة
                
                
                let email = (txtEmailRegister.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                let password = txtPassRegister.text ?? ""
                let name = "\(txtFirstName.text ?? "") \(txtLastName.text ?? "")"
                let dob = myDate
                let phone = formatphone
                let gender = gender
                let role = isDoctor
                
                
                print(email)
                print(password)
                print(name)
                print(dob)
                print(phone)
                print(gender)
                print(role)
                api.signUpUser(
                    firstName: txtFirstName.text ?? "",
                    lastName: txtLastName.text ?? "",
                    email: email,
                    password: password,
                    phone: phone,
                    gender: gender,
                    dateOfBirth: myDate,
                    role: isDoctor
                ) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            print("✅ \(response.message)")
                            print("👤 Created user: \(response.data.name), role: \(response.data.role)")
                            
                            // الانتقال بعد النجاح
                            
                            self.myScrollView.isHidden = true
                            self.logInView.isHidden = false
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            if let resetVC = storyboard.instantiateViewController(withIdentifier: "Success") as? SuccessVC {
                                resetVC.titlelbl = "مرحباً \(self.txtFirstName.text ?? "")"
                                resetVC.suptitlelbl = "لقد انشأت حسابك بنجاح"
                                resetVC.msglbl = "قم بتسجيل الدخول في الخطوة التالية وأبدا بملئ بياناتك فى ملفك الشخصي"
                                resetVC.loadViewIfNeeded() // ضروري قبل التعديل على الـ outlets
                                resetVC.logout.isHidden = true
                                
                                resetVC.modalPresentationStyle = .fullScreen
                                resetVC.modalTransitionStyle = .crossDissolve
                                self.present(resetVC, animated: true)
                            }
                            
                        case .failure(let error):
                            self.errorRegisterMsg.textColor = .appRed
                            self.errorRegisterMsg.isHidden = false
                            self.errorRegisterMsg.text = error.localizedDescription
                            
                            print("❌ Sign up error: \(error.localizedDescription)")
                        }
                    }
                }
            }else {
                //  اهتز فقط الشروط اللي فيها أخطاء (لونها أحمر)
                
                
                if CheckMarkForEmail.tintColor == .appRed {
                    shake(txtEmailRegister)
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    errorRegisterMsg.text = "البريد الإلكتروني غير صحيح"
                    
                    
                }
                if lblPasswordMatches.textColor == .appRed || markPasswordMatches.tintColor == .appRed {
                    shake(txtConfirmPassRegister)
                    shake(txtPassRegister)
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    txtPassRegister.layer.borderColor = UIColor.red.cgColor
                    txtConfirmPassRegister.layer.borderColor = UIColor.red.cgColor
                    
                    errorRegisterMsg.text = "يجب ان تحقق شروط كلمة السر"
                    
                }
                
                if lblPassword8letters.textColor == .appRed || markPassword8letters.tintColor == .appRed {
                    shake(txtPassRegister)
                    txtPassRegister.layer.borderColor = UIColor.red.cgColor
                    
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    
                    errorRegisterMsg.text = "يجب ان تحقق شروط كلمة السر"
                    
                }
                
                if lbllblPasswordHasNumbers.textColor == .appRed || marklblPasswordHasNumbers.tintColor == .appRed {
                    shake(txtPassRegister)
                    txtPassRegister.layer.borderColor = UIColor.red.cgColor
                    
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    
                    errorRegisterMsg.text = "يجب ان تحقق شروط كلمة السر"
                    
                }
                
                if lblUnallowedSymbols.textColor == .appRed || markUnallowedSymbols.tintColor == .appRed {
                    shake(txtPassRegister)
                    txtPassRegister.layer.borderColor = UIColor.red.cgColor
                    
                    self.errorRegisterMsg.textColor = .appRed
                    self.errorRegisterMsg.isHidden = false
                    
                    errorRegisterMsg.text = "يجب ان تحقق شروط كلمة السر"
                    
                }
                
                //  ممكن تضيف اهتزاز بسيط للشاشة كتنبيه عام (اختياري)
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
        }
    }
    

    // MARK: - Register as Doctor
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // تخزين القيم
        currentLat = String(latitude)
        currentLon = String(longitude)
        
        print("Lat: \(latitude)")
        print("Lon: \(longitude)")
        
        // تحريك الماب
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )
        
        doctorLocation.setRegion(region, animated: true)
        
        // لو عايز يوقف التحديث بعد ما يجيب اللوكيشن
        locationManager.stopUpdatingLocation()
    }

    public func createAccDoctor(){
        
        var email = (txtEmailRegister.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        var password = txtPassRegister.text ?? ""
        var firstName = txtFirstName.text ?? ""
        var lastName = txtLastName.text ?? ""
        var dob = myDate
        var phone = formatphone
        var gender = gender
        var role = isDoctor
        var specialization = specializationLbl.text ?? ""
        var bio = bioLbl.text ?? ""
        var practicalExperience = practicalExperienceLbl.text ?? ""
        var latitude = currentLat
        var longitude = currentLon
    }

    
    
    
    @IBAction func bsckStageButton(_ sender: Any) {

        if stageNumber == 1{
            backStage.isHidden = true
            stageNumber -= 1
            completionStageImage.image = complateImages[0]

            firstStageView.isHidden = false
            secondStageView.isHidden = true

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
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtPhoneRegister { // تأكد إن ده حقل الهاتف
            textField.text = formatPhoneNumber(textField.text ?? "")
        }
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
        shake(textField)
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
    
//    private func shake(textField: UITextField) {
//        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
//        animation.timingFunction = CAMediaTimingFunction(name: .linear)
//        animation.duration = 0.4
//        animation.values = [-10, 10, -8, 8, -5, 5, 0]
//        textField.layer.add(animation, forKey: "shake")
//    }
    
    private func shake<T>(_ view: T) {
        guard let uiView = view as? UIView else { return }
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 0.4
        
        // Smooth decreasing amplitude pattern
        let amplitudes: [CGFloat] = [10, -10, 8, -8, 5, -5, 0]
        animation.values = amplitudes
        
        // Avoid overlapping animations by removing old ones
        uiView.layer.removeAnimation(forKey: "shake")
        uiView.layer.add(animation, forKey: "shake")
    }


}
