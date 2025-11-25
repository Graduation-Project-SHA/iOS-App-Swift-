//
//  MasterCardViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/17/25.
//

import UIKit

class MasterCardViewController: UIViewController {
    
    @IBOutlet weak var checkMarkMeeza: UIImageView!
    @IBOutlet weak var meeza: UIButton!
    
    @IBOutlet weak var checkMarkMsterCard: UIImageView!
    @IBOutlet weak var masterCard: UIButton!
    
    @IBOutlet weak var checkMarkVisa: UIImageView!
    @IBOutlet weak var visa: UIButton!
    
    @IBOutlet weak var Expiration: UIDatePicker!
    
    @IBOutlet weak var checkSaveCard: UIImageView!
    @IBOutlet weak var saveCard: UISwitch!
    
    @IBOutlet weak var myView: UIView!
    
    var selectedMasterCard: Bool = false
    var selectedMeezaCard: Bool = false
    var selectedVisaCard: Bool = false
    var selectedSave: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // إخفاء العلامات
        checkMarkVisa.isHidden = true
        checkSaveCard.isHidden = true
        checkMarkMeeza.isHidden = true
        checkMarkMsterCard.isHidden = true
        
        // كرت المحتوى
        myView.layer.cornerRadius = 30
        myView.layer.masksToBounds = false
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOffset = CGSize(width: 0, height: 5)
        myView.layer.shadowRadius = 10
        myView.layer.shadowOpacity = 0.3
        
        // تهيئة الأزرار مع المحافظة على الصور اللي وراهم
        setupCardButton(meeza)
        setupCardButton(masterCard)
        setupCardButton(visa)
    }
    
    // MARK: - أزرار اختيار نوع البطاقة
    
    @IBAction func meezaButton(_ sender: Any) {
        selectedMeezaCard = true
        selectedMasterCard = false
        selectedVisaCard = false
        
        updateCardButtonsAppearance()
        
        checkMarkMeeza.isHidden = false
        checkMarkMsterCard.isHidden = true
        checkMarkVisa.isHidden = true
    }
    
    @IBAction func masterCardButton(_ sender: Any) {
        selectedMeezaCard = false
        selectedMasterCard = true
        selectedVisaCard = false
        
        updateCardButtonsAppearance()
        
        checkMarkMeeza.isHidden = true
        checkMarkMsterCard.isHidden = false
        checkMarkVisa.isHidden = true
    }
    
    @IBAction func visaButton(_ sender: Any) {
        selectedMeezaCard = false
        selectedMasterCard = false
        selectedVisaCard = true
        
        updateCardButtonsAppearance()
        
        checkMarkMeeza.isHidden = true
        checkMarkMsterCard.isHidden = true
        checkMarkVisa.isHidden = false
    }
    
    // MARK: - حفظ البطاقة
    
    @IBAction func saveCardButton(_ sender: Any) {
        if selectedSave {
            checkSaveCard.isHidden = true
        } else {
            checkSaveCard.isHidden = false
        }
        selectedSave.toggle()
    }
    
    // MARK: - Navigation
    
    @IBAction func doneButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Pin") as? PinViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Payment") as? PaymentViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
    }
    
    // MARK: - Helpers
    
    private func setupCardButton(_ button: UIButton) {
        // خليه ما يغمق الصورة عند الضغط
        button.adjustsImageWhenHighlighted = false
        
        // حدود و corner radius بدون ما نخرب الخلفية/الصورة
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        // ما نغير backgroundColor عشان الصورة اللي ورا تبقى
        // button.backgroundColor = .clear
    }
    
    private func updateCardButtonsAppearance() {
        // Meeza
        if selectedMeezaCard {
            highlight(button: meeza)
        } else {
            unhighlight(button: meeza)
        }
        
        // MasterCard
        if selectedMasterCard {
            highlight(button: masterCard)
        } else {
            unhighlight(button: masterCard)
        }
        
        // Visa
        if selectedVisaCard {
            highlight(button: visa)
        } else {
            unhighlight(button: visa)
        }
    }
    
    private func highlight(button: UIButton) {
        // مثلاً نخلي الحدود أزرق ونزيد السماكة
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.configuration = .tinted()
        button.layer.borderWidth = 1
        // لو حاب تضيف خلفية خفيفة:
        // button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.08)
    }
    
    private func unhighlight(button: UIButton) {
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.configuration = .plain()

        button.layer.borderWidth = 1
        // نرجع الخلفية لوضعها الطبيعي (شفاف عشان الصور تبان)
        // button.backgroundColor = .clear
    }
}
