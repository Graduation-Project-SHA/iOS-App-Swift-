//
//  LogIngVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/17/25.
//

import UIKit

class LogIngVC: UIViewController {

    var iAmDoctor:Bool = false
    
    @IBOutlet weak var logo: UILabel!
    
    
    @IBOutlet weak var lblStartNow: UILabel!
    
    
    @IBOutlet weak var lblMarketing: UILabel!
    
    @IBOutlet weak var authView: UIView!
    
    @IBOutlet weak var normalUser: UIButton!
    
    
    @IBOutlet weak var doctor: UIButton!
    
    @IBOutlet weak var segmentLogInAndSignUP: UISegmentedControl!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authView.layer.cornerRadius = 20
        segmentLogInAndSignUP.tintColor = .white
        
        
        
        
    }

    @IBAction func normalUserButton(_ sender: Any) {
    }
    
    @IBAction func doctorButton(_ sender: Any) {
        iAmDoctor = true
    }
    
}

