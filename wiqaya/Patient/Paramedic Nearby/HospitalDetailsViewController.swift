//
//  HospitalDetailsViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/22/25.
//

import UIKit
import MapKit
class HospitalDetailsViewController: UIViewController {

    @IBOutlet weak var hospitalDetailsView: UIView!
    
    
    @IBOutlet weak var detailsView: UIView!
    
    @IBOutlet weak var bookingNumberView: UIView!
    
    @IBOutlet weak var clockView: UIView!
    
    
    @IBOutlet weak var addressView: UIView!
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var requestCarAmbulance: UIButton!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hospitalDetailsView.layer.cornerRadius = 15
        hospitalDetailsView.layer.masksToBounds = true
        hospitalDetailsView.layer.borderWidth = 1
        hospitalDetailsView.layer.borderColor = UIColor(hex: "E5E5E5").cgColor
        
        detailsView.layer.cornerRadius = 15
        detailsView.layer.masksToBounds = true
        detailsView.layer.borderWidth = 1
        detailsView.layer.borderColor = UIColor(hex: "E5E5E5").cgColor

        clockView.layer.cornerRadius = 15
        clockView.layer.masksToBounds = true
        clockView.layer.borderWidth = 1
        clockView.layer.borderColor = UIColor(hex: "E5E5E5").cgColor

        addressView.layer.cornerRadius = 15
        addressView.layer.masksToBounds = true
        addressView.layer.borderWidth = 1
        addressView.layer.borderColor = UIColor(hex: "E5E5E5").cgColor

        bookingNumberView.layer.cornerRadius = 10
        myMap.layer.cornerRadius = 10
        requestCarAmbulance.tintColor = UIColor(hex: "E7000B")

        
        
    }
    
    @IBAction func requestCarAmbulanceButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Emergency") as? EmergencyViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

    }
    @IBAction func backbutton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "ParamedicNearby") as? ParamedicNearbyViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
        
    }

    

}
