//
//  HospitalMapViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 1/22/26.
//

import UIKit

class HospitalMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var myTableView: UITableView!
    var array = [ItemHospital]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        implementData()
        
        

    }
    func implementData() {
        array.append(ItemHospital(name: "مستشفى نور الشروق 1", address: "طريق الشباب", lblAddressCar: "20 دقيقة ", lblAddress: "20 دقيقة", lblDistance: "1.2 كم"))
        array.append(ItemHospital(name: "مستشفى نور الشروق 2", address: "طريق الشباب", lblAddressCar: "25 دقيقة ", lblAddress: "25 دقيقة", lblDistance: "2.3 كم"))
        array.append(ItemHospital(name: "مستشفى نور الشروق 3", address: "طريق الشباب", lblAddressCar: "15 دقيقة ", lblAddress: "15 دقيقة", lblDistance: "0.8 كم"))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParamedicTableViewCell
        cell.hospitalName.text = array[indexPath.row].name
        cell.hospitalAddress.text = array[indexPath.row].address
        cell.lblAddressCar.text = array[indexPath.row].lblAddressCar
        cell.lblAddress.text = array[indexPath.row].lblAddress
        cell.lblDistance.text = array[indexPath.row].lblDistance
        
        cell.onButtonTap = { [weak self] in
            guard let self = self else { return }
            
            let storyboard = UIStoryboard(name: "Patient", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "HospitalDetails") as? HospitalDetailsViewController {
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                self.present(loginVC, animated: false)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    // لما يختار مستشفى من الجدول
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "HospitalDetails") as? HospitalDetailsViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: false)
        }
    }


}
struct ItemHospital {
    var name : String
    var address : String
    var lblAddressCar : String
    var lblAddress : String
    var lblDistance : String
}
