//
//  ComplateDatesTableViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/28/25.
//

import UIKit

class ComplateDatesTableViewController: UITableViewController {
    var complateDateArray = [nextDateItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PatiantsComplateDatesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")

        loadData()
    }

    private func loadData() {
        complateDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        complateDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        complateDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        complateDateArray.append(nextDateItem(
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
        return complateDateArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PatiantsComplateDatesTableViewCell

        cell.patiantImage.image = complateDateArray[indexPath.row].doctorImage
        cell.patiantName.text = complateDateArray[indexPath.row].nameDoctor
        cell.date.text = complateDateArray[indexPath.row].date
        cell.clock.text = complateDateArray[indexPath.row].clock
        cell.consultationType.text = complateDateArray[indexPath.row].specialtyDoctor

        return cell
    }
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
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

}
