//
//  resetPassVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/21/25.
//

//
//  resetPassVC.swift
//  wiqaya
//

import UIKit

class resetPassVC: UIViewController {
    
    let api = APIService()
    
    // ✅ القيم اللي جاية من OTPVC
    var email: String = ""
    var otp: String = ""
    
    @IBOutlet weak var txtpass: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var errorRegisterMsg: UILabel!
    
    var passError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorRegisterMsg.isHidden = true
        
        [txtpass, txtConfirmPass].forEach {
            $0?.isSecureTextEntry = true
            $0?.layer.cornerRadius = 8
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
        }
    }
    
    // MARK: - Reset Password
    @IBAction func resetPassButton(_ sender: Any) {
        
        guard
            let password = txtConfirmPass.text,
            !password.isEmpty,
            !passError
        else {
            errorRegisterMsg.isHidden = false
            errorRegisterMsg.text = "تحقق من شروط كلمة المرور"
            return
        }
        
        api.resetPassword(
            email: email,
            otp: otp,
            newPassword: password
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let successVC = storyboard.instantiateViewController(withIdentifier: "Success") as? SuccessVC {
                        successVC.titlelbl = "تم تغيير كلمة السر بنجاح"
                        successVC.msglbl = "يمكنك تسجيل الدخول الآن"
                        successVC.logout.isHidden = true
                        successVC.modalPresentationStyle = .fullScreen
                        self.present(successVC, animated: true)
                    }
                    
                case .failure(let error):
                    self.errorRegisterMsg.isHidden = false
                    self.errorRegisterMsg.text = error.message?.first ?? "حدث خطأ ما"
                }
            }
        }
    }
}
