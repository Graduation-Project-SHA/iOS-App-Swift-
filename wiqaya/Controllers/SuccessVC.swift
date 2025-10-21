//
//  SuccessVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/21/25.
//

import UIKit

class SuccessVC: UIViewController {

    var titlelbl : String = ""
    var suptitlelbl : String = ""
    var msglbl : String = ""
    
    
    @IBOutlet weak var title1: UILabel!
    
    
    @IBOutlet weak var suptitle: UILabel!
    
    
    @IBOutlet weak var msg: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title1.text = titlelbl
        suptitle.text = suptitlelbl
        msg.text = msglbl
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let otpVC = storyboard.instantiateViewController(withIdentifier: "Login") as? LogIngVC {
            otpVC.modalPresentationStyle = .fullScreen
            otpVC.modalTransitionStyle = .crossDissolve
            present(otpVC, animated: true)
        }
        
    }
    

}
