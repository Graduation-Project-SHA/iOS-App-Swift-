//
//  CancelDatesTableViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/29/25.
//

import UIKit

class CancelDatesTableViewController: UITableViewController {
    var cancelDateArray = [nextDateItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "PatiantCancelDatesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cancelCell")
        
        loadData()
    }
    private func loadData() {
        cancelDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        cancelDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        cancelDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        cancelDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        tableView.reloadData()   // 👈 يحدّث الجدول
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cancelDateArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cancelCell", for: indexPath) as! PatiantCancelDatesTableViewCell
        
        cell.patiantImage.image = cancelDateArray[indexPath.row].doctorImage
        cell.patiantName.text = cancelDateArray[indexPath.row].nameDoctor
        cell.date.text = cancelDateArray[indexPath.row].date
        cell.clock.text = cancelDateArray[indexPath.row].clock
        cell.consultationType.text = cancelDateArray[indexPath.row].specialtyDoctor
        
        return cell
    }
    override func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10   // تقدر تغيّرها حسب ما يعجبك
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00000001
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Doctor", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "MedicalRecordPage") as? MedicalRecordPageViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

    }

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView()
//        header.backgroundColor = UIColor(hex: "1C1C1E")  // غامق
//        return header
//    }
}
