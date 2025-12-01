//
//  AvailableAppointmentsViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/1/25.
//

import UIKit

class AvailableAppointmentsViewController: UIViewController {

    
    @IBOutlet weak var viewSaturday: UIView!
    @IBOutlet weak var saturdayCheck: UIImageView!
    
    
    @IBOutlet weak var viewSunday: UIView!
    @IBOutlet weak var sundayCheck: UIImageView!
    
    
    @IBOutlet weak var viewMonday: UIView!
    @IBOutlet weak var mondayCheck: UIImageView!
    
    
    @IBOutlet weak var viewTuesday: UIView!
    @IBOutlet weak var tuesdayCheck: UIImageView!
    
    
    @IBOutlet weak var viewWednesday: UIView!
    @IBOutlet weak var wednesdayCheck: UIImageView!
    
    
    @IBOutlet weak var viewThursday: UIView!
    @IBOutlet weak var thursdayCheck: UIImageView!
    
    
    @IBOutlet weak var viewFriday: UIView!
    @IBOutlet weak var friddayCheck: UIImageView!
    
    
    @IBOutlet weak var tableViewDailyWorking: UITableView!
    
    
    @IBOutlet weak var tableViewSummary: UITableView!
    
    
    
    
    var counter : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "إدارة المواعيد المتاحة"
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

    }
    


}
extension AvailableAppointmentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyWorkingTableViewCell
        
        return cell
    }
    
    
}
