//
//  DoctorUpcomingDatesTableViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/27/25.
//

import UIKit

class DoctorUpcomingDatesTableViewController: UITableViewController {
    
    var upcomingDateArray = [nextDateItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // تسجيل الـ cell الصح
        let nib = UINib(nibName: "PatiantsInDoctorUpcomingDatesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UpComingcell")
        
        loadData()
    }
    
    private func loadData() {
        upcomingDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        upcomingDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        upcomingDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "Doctor")!,
            nameDoctor: "احمد الشافعى",
            specialtyDoctor: "استشاره",
            clock: "08.30 AM",
            date: "Wed, 17 May"
        ))
        
        upcomingDateArray.append(nextDateItem(
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
        return upcomingDateArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingDateArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "UpComingcell",
            for: indexPath
        ) as! PatiantsInDoctorUpcomingDatesTableViewCell
        
        let item = upcomingDateArray[indexPath.row]
        cell.patiantBookingImage.image = item.doctorImage
        cell.patiantBookingName.text   = item.nameDoctor
        cell.bookingType.text          = item.specialtyDoctor
        cell.bookingDate.text          = item.date
        cell.bookingTime.text          = item.clock
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
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
