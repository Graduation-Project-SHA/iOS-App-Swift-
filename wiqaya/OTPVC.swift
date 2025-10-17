//
//  OTPVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/17/25.
//

import UIKit

class OTPVC: UIViewController {
    
    // MARK: - Variables
    var country: String = ""
    var phoneCode: String = ""
    
    // MARK: - Outlets
    @IBOutlet weak var pullbutton: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var countryImage: UIImageView!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var mainPhoneNumber: UILabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [txtPhone].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 1.0
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
        phoneView.isHidden = true

        // إعداد مظهر صورة العلم
        countryImage.contentMode = .scaleAspectFit
        countryImage.clipsToBounds = true
        
        // إعداد الزرار
        pullbutton.setTitle("", for: .normal) // نخليه من غير نص
        pullbutton.showsMenuAsPrimaryAction = true
        
        // تهيئة القائمة المنسدلة
        configurePullDownButton()
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
        txtPhone.placeholder = phoneCode
        
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
    
    // MARK: - Back Button Action
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
