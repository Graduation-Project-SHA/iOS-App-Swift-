//
//  MedicalRecordPageViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/29/25.
//

import UIKit

class MedicalRecordPageViewController: UIViewController {

    
    @IBOutlet weak var sesstionView: UIView!
    
    @IBOutlet weak var medicineView: UIView!
    
    @IBOutlet weak var warningInMedicineView: UIView!
    
    
    @IBOutlet weak var medicineTableView: UITableView!
    
    @IBOutlet weak var MedicalHistoryTableView: UITableView!
    
    @IBOutlet weak var medicalHistotyView: UIView!
    var medicalRecordArray = [MedicalRecord]()
    var medicalHistoryArray = [MedicalHistory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        medicineTableView.delegate = self
        medicineTableView.dataSource = self
        MedicalHistoryTableView.delegate = self
        MedicalHistoryTableView.dataSource = self
        
        sesstionView.layer.cornerRadius = 14
        sesstionView.clipsToBounds = true
        
        sesstionView.layer.borderWidth = 1
        sesstionView.layer.borderColor = UIColor(hex: "BEDBFF").cgColor
        
        medicineView.layer.cornerRadius = 14
        medicineView.clipsToBounds = true
        
        medicineView.layer.borderWidth = 1
        medicineView.layer.borderColor = UIColor(hex: "FEE685").cgColor

        
        warningInMedicineView.layer.cornerRadius = 10
        warningInMedicineView.clipsToBounds = true
        warningInMedicineView.layer.borderWidth = 1
        warningInMedicineView.layer.borderColor = UIColor(hex: "FFC9C9").cgColor
        
        medicalHistotyView.layer.cornerRadius = 10
        medicalHistotyView.clipsToBounds = true
        medicalHistotyView.layer.borderWidth = 1
        medicalHistotyView.layer.borderColor = UIColor(hex: "BEDBFF").cgColor
        
        implementData()
    }
    func implementData(){
        medicalRecordArray.append(MedicalRecord(treatmentName: "ليسينوبريل", treatmentStatus: "مزمن", quantity: "10 ملجم", appointments: "مرة واحدة يومياً"))
        medicalRecordArray.append(MedicalRecord(treatmentName: "أسبرين", treatmentStatus: "مزمن", quantity: "81 ملجم", appointments: "مرة واحدة يومياً"))
        medicalRecordArray.append(MedicalRecord(treatmentName: "أتورفاستاتين", treatmentStatus: "مزمن", quantity: "20 ملجم", appointments: "مرة واحدة يومياً (مساءً)"))
        medicalRecordArray.append(MedicalRecord(treatmentName: "ليسينوبريل", treatmentStatus: "مزمن", quantity: "5 ملجم", appointments: "مرة واحدة يومياًمرةمرة واحدة يومياً (مساءً)مرة واحدة يومياً (مساءً) واحدة يومياً (مساءً)"))
        medicalRecordArray.append(MedicalRecord(treatmentName: "ليسينوبريل", treatmentStatus: " مزمن مزمن", quantity: "10 ملجم", appointments: "مرة واحدة يومياً"))
        
        medicalHistoryArray.append(MedicalHistory(
            date: "2024-04-18",
            lblMedicalStatus: "متابعة علاجالتهاب فيروسي في الجهاز التنفسي العلوي",
            pharmaceutical1: ["مسكنات الالم","مضاد للاحتقان"],
            pharmaceutical2: ["مسكنات الالم","مضاد للاحتقان"],
            procedures: ["مراجعة طبيب باطنة", "فحص سريري شامل"]
        ))
        medicalHistoryArray.append(MedicalHistory(
            date: "2024-04-18",
            lblMedicalStatus: "متابعة علاج",
            pharmaceutical1: ["باراسيتامول 500 ملجم ملجم", "باراسيتامول 500 ملجم"],
            pharmaceutical2: ["باراسيتامول 500 ملجم ملجم", "باراسيتامول 500 ملجم"],
            procedures: ["فحص سريري شامل كامل متكامل", "اشعه"]
        ))
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
extension MedicalRecordPageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == MedicalHistoryTableView{
            return 1
        }else{
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == MedicalHistoryTableView{
            return medicalHistoryArray.count
        }else{
            return medicalRecordArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == medicineTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MedicalRecordTableViewCell
            cell.treatmentName.text = medicalRecordArray[indexPath.section].treatmentName
            cell.treatmentStatus.text = medicalRecordArray[indexPath.section].treatmentStatus
            cell.appointments.text = medicalRecordArray[indexPath.section].appointments
            cell.quantity.text = medicalRecordArray[indexPath.section].quantity
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MedicalHistoryTableViewCell
            cell.date.text = medicalHistoryArray[indexPath.section].date
            cell.lblMedicalStatus.text = medicalHistoryArray[indexPath.section].lblMedicalStatus
            cell.pharmaceutical1 = medicalHistoryArray[indexPath.section].pharmaceutical1
            cell.pharmaceutical2 = medicalHistoryArray[indexPath.section].pharmaceutical2
            cell.procedures = medicalHistoryArray[indexPath.section].procedures

            cell.reloadCollections()

            return cell

        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5   // تقدر تغيّرها حسب ما يعجبك
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00000001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor .white
        return header
    }
}

struct MedicalRecord {
    var treatmentName : String
    var treatmentStatus : String
    var quantity : String
    var appointments : String
}
struct MedicalHistory {
    var date : String
    var lblMedicalStatus : String
    var pharmaceutical1 = [String]()
    var pharmaceutical2 = [String]()
    var procedures = [String]()
}
