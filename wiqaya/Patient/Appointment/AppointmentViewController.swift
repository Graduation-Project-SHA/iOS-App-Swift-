//
//  AppointmentViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/20/25.
//

import UIKit

class AppointmentViewController: UIViewController {

    
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var completedView: UIView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var myScroll: UIScrollView!
    var array = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        completedView.isHidden = true
        
        setUpArray()
        nextAppointment()
        myTableView.separatorStyle = .none
    }
    
    @IBAction func backbutton(_ sender: Any) {
        dismiss(animated: true)
        
    }

    
    func setUpArray() {
        array = [
            Item(status: UIImage(named: "canceled")!,
                 image: UIImage(named: "Doctor")!,
                 name: "د. احمد",
                 speciality: "اسنان"),
            
            Item(status: UIImage(named: "canceled")!,
                 image: UIImage(named: "Doctor")!,
                 name: "د. عمر",
                 speciality: "عيون"),
            
            Item(status: UIImage(named: "completed")!,
                 image: UIImage(named: "Doctor")!,
                 name: "د. ناصر",
                 speciality: "انف و اذن و حنجرة"),
            Item(status: UIImage(named: "canceled")!,
                 image: UIImage(named: "Doctor")!,
                 name: "د. احمد",
                 speciality: "اسنان"),
            
            Item(status: UIImage(named: "canceled")!,
                 image: UIImage(named: "Doctor")!,
                 name: "د. عمر",
                 speciality: "عيون"),
            
            Item(status: UIImage(named: "completed")!,
                 image: UIImage(named: "Doctor")!,
                 name: "د. ناصر",
                 speciality: "انف و اذن و حنجرة")
        ]

    }
    
    
    
    @IBAction func segmentButton(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            nextAppointment()
        } else if sender.selectedSegmentIndex == 1 {
            previousAppointment()
        }
    }
    
    private func nextAppointment() {
        // Remove previous child controllers
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        completedView.isHidden = true
        contentView.isHidden = false
        myScroll.isHidden = false
        
        
        let searchVC = ComingDatesViewController(nibName: "ComingDatesViewController", bundle: nil)
        addChild(searchVC)
        searchVC.view.frame = contentView.bounds
        searchVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(searchVC.view)
        searchVC.didMove(toParent: self)
    }
    private func previousAppointment() {
        completedView.isHidden = false
        contentView.isHidden = true
        myScroll.isHidden = true
        myTableView.reloadData()
    }

}
extension AppointmentViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 👇 عدد السكاشن = عدد العناصر في الآراي
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
    // 👇 كل سكشن فيه رو واحد فقط
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 👇 تهيئة الخلية
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PreviousDatesTableViewCell
        
        let item = array[indexPath.section]   // لاحظ استخدمنا section بدل row
        
        cell.doctorimage.image = item.image
        cell.doctorName.text = item.name
        cell.specialty.text = item.speciality
        cell.status.image = item.status
        if item.status == UIImage(named: "canceled") {
            cell.cancelView.isHidden = false
            cell.completedView.isHidden = true
        } else {
            cell.cancelView.isHidden = true
            cell.completedView.isHidden = false
        }

        
        return cell
    }
    
    // 👇 ارتفاع الخلية
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105 // غيّر الرقم على حسب تصميمك
    }
    
    // 👇 المسافة بين الخلايا (هنا الهيدر بين كل سكشن وسكشن)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
        // هذه هي المسافة
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
struct Item {
    var status : UIImage
    var image : UIImage
    var name : String
    var speciality : String
}
