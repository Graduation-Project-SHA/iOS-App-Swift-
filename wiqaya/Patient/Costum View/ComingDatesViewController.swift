//
//  ComingDatesViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/19/25.
//

import UIKit

class ComingDatesViewController: UIViewController {
    
    @IBOutlet weak var setAlarm: UIButton!
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var myView2: UIView!
    
    @IBOutlet weak var howFeelView: UIView!
    
    let gradient = GradientManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        myView.layer.cornerRadius = 20
        myView2.layer.cornerRadius = 20
        howFeelView.layer.cornerRadius = 10
        


        

    }
    


}
