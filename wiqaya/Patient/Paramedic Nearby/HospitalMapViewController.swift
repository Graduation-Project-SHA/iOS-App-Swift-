//
//  HospitalMapViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 1/22/26.
//

import UIKit

class HospitalMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var array = [ItemHospital]()
    
    // ✅ Added: callback للـ parent (الخريطة) لما تختار مستشفى
    var onHospitalSelected: ((Int, ItemHospital) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // ✅ لو الـ array اتبعتت من برّه (ParamedicNearby) ما نكررش الداتا
        if array.isEmpty {
            implementData()
        }
    }
    
    func implementData() {
        // ✅ Prevent duplicates لو viewDidLoad اتكرر
        array.removeAll()
        
        array.append(ItemHospital(name: "مستشفى نور الشروق 1", address: "طريق الشباب", lblAddressCar: "20 دقيقة ", lblAddress: "20 دقيقة", lblDistance: "1.2 كم"))
        array.append(ItemHospital(name: "مستشفى نور الشروق 2", address: "طريق الشباب", lblAddressCar: "25 دقيقة ", lblAddress: "25 دقيقة", lblDistance: "2.3 كم"))
        array.append(ItemHospital(name: "مستشفى نور الشروق 3", address: "طريق الشباب", lblAddressCar: "15 دقيقة ", lblAddress: "15 دقيقة", lblDistance: "0.8 كم"))
    }
    
    // ✅ Added: عشان الخريطة تختار Row جوّه الجدول بسهولة
    func selectHospitalRow(index: Int, animated: Bool = true) {
        guard index >= 0, index < array.count else { return }
        let indexPath = IndexPath(row: index, section: 0)
        
        myTableView.selectRow(at: indexPath, animated: animated, scrollPosition: .middle)
        
        // نبلغ الـ parent (الخريطة) بالاختيار
        onHospitalSelected?(index, array[index])
    }
    // ✅ وميض للـ Row اللي اتحدد
    func flashRow(index: Int) {
        guard index >= 0, index < array.count else { return }
        
        // تأكد إن الـ view اتعملها load
        loadViewIfNeeded()
        myTableView.layoutIfNeeded()
        
        let indexPath = IndexPath(row: index, section: 0)
        
        // اختار الـ row + اعمل scroll
        myTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        myTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        
        // استنى شوية لحد ما الـ cell تبقى visible ثم اعمل animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
            guard let self = self else { return }
            
            // لو لسه مش ظاهرة (animated scroll)، جرب تاني بعد وقت بسيط
            if let cell = self.myTableView.cellForRow(at: indexPath) {
                self.flashCell(cell)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                    if let cell2 = self.myTableView.cellForRow(at: indexPath) {
                        self.flashCell(cell2)
                    }
                }
            }
        }
    }
    
    private func flashCell(_ cell: UITableViewCell) {
        let originalColor = cell.contentView.backgroundColor
        let originalTransform = cell.transform
        
        UIView.animate(withDuration: 0.12, animations: {
            cell.contentView.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.9)
            cell.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.15, options: [.curveEaseOut], animations: {
                cell.contentView.backgroundColor = originalColor
                cell.transform = originalTransform
            }, completion: nil)
        }
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
            
            // ✅ Added: بلغ الخريطة قبل فتح التفاصيل (اختياري بس مفيد)
            self.onHospitalSelected?(indexPath.row, self.array[indexPath.row])
            
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
        
        // ✅ Added: بلغ الخريطة مين اتختار
        onHospitalSelected?(indexPath.row, array[indexPath.row])
        
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "HospitalDetails") as? HospitalDetailsViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: false)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
    }
    
    
}

struct ItemHospital {
    var name: String
    var address: String
    var lblAddressCar: String
    var lblAddress: String
    var lblDistance: String
}
