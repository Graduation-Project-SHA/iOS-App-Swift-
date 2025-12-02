//
//  AvailableAppointmentsViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/1/25.
//

import UIKit

struct DailayTimeItem {
    var from: String
    var to: String
}

class AvailableAppointmentsViewController: UIViewController {
    
    @IBOutlet weak var heightTableViewWork: NSLayoutConstraint!
    
    @IBOutlet weak var heightAllView: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewSaturday: UIView!
    @IBOutlet weak var saturdayCheck: UIImageView!
    @IBOutlet weak var lblSaturday: UILabel!
    
    @IBOutlet weak var viewSunday: UIView!
    @IBOutlet weak var sundayCheck: UIImageView!
    @IBOutlet weak var lblSunday: UILabel!
    
    @IBOutlet weak var viewMonday: UIView!
    @IBOutlet weak var mondayCheck: UIImageView!
    @IBOutlet weak var lblMonday: UILabel!
    
    @IBOutlet weak var viewTuesday: UIView!
    @IBOutlet weak var tuesdayCheck: UIImageView!
    @IBOutlet weak var lblTuesday: UILabel!
    
    @IBOutlet weak var viewWednesday: UIView!
    @IBOutlet weak var wednesdayCheck: UIImageView!
    @IBOutlet weak var lblWednesday: UILabel!
    
    @IBOutlet weak var viewThursday: UIView!
    @IBOutlet weak var thursdayCheck: UIImageView!
    @IBOutlet weak var lblThursday: UILabel!
    
    @IBOutlet weak var viewFriday: UIView!
    @IBOutlet weak var friddayCheck: UIImageView!
    @IBOutlet weak var lblFriday: UILabel!
    
    @IBOutlet weak var tableViewDailyWorking: UITableView!
    @IBOutlet weak var tableViewSummary: UITableView!
    
    
    
    
    
    
    var selectedDays: Set<Int> = []
    var workingTimesByDay: [Int: [DailayTimeItem]] = [:]
    
    var daysViews: [UIView] = []
    var daysChecks: [UIImageView] = []
    var daysLabels: [UILabel] = []
    
    let dayNames = ["السبت", "الأحد", "الإثنين", "الثلاثاء",
                    "الأربعاء", "الخميس", "الجمعة"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup days views
        let views = [viewSaturday, viewSunday, viewMonday, viewTuesday,
                     viewWednesday, viewThursday, viewFriday]
        let checks = [saturdayCheck, sundayCheck, mondayCheck, tuesdayCheck,
                      wednesdayCheck, thursdayCheck, friddayCheck]
        let labels = [lblSaturday, lblSunday, lblMonday, lblTuesday,
                      lblWednesday, lblThursday, lblFriday]
        
        for v in views {
            v?.layer.cornerRadius = 10
            v?.layer.masksToBounds = true
            v?.layer.borderWidth = 1
            v?.layer.borderColor = UIColor(hex: "E5E7EB").cgColor
        }
        
        daysViews = views.compactMap { $0 }
        daysChecks = checks.compactMap { $0 }
        daysLabels = labels.compactMap { $0 }
        
        tableViewDailyWorking.delegate = self
        tableViewDailyWorking.dataSource = self
        tableViewSummary.delegate = self
        tableViewSummary.dataSource = self
        heightTableViewWork.constant = 50
        heightAllView.constant = 900

    }
    func updateDaysHeight() {
        if selectedDays.isEmpty {
            heightTableViewWork.constant = 50
            heightAllView.constant = 900
        } else {
            heightTableViewWork.constant = 450
            heightAllView.constant = 1400

        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let titleLabel = UILabel()
        titleLabel.text = "إدارة المواعيد المتاحة"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textAlignment = .right
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail  // ← مهم حتى لا يخرج برّا
        
        // container لتحديد العرض
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        
        // قيود تحكم بحيث لا يخرج خارج الشاشة
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            // أقصى عرض للعنوان (ثلثي عرض الشاشة)
            container.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 0.6)
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let rightItem = UIBarButtonItem(customView: container)
        navigationItem.rightBarButtonItem = rightItem
        
        // أخفي العنوان الأصلي
        navigationItem.title = ""
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black  // ← اختار اللون اللي تريده
        ]
        appearance.shadowColor = .clear        // أهم واحدة
        appearance.shadowImage = UIImage()     // بعض الأنظمة تحتاجها

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }

    // MARK: - Day Selection
    func updateDaysUI() {
        for i in 0..<daysViews.count {
            let dayView = daysViews[i]
            let check = daysChecks[i]
            let label = daysLabels[i]
            
            let isSelected = selectedDays.contains(i)
            if isSelected {
                dayView.backgroundColor = UIColor(hex: "026CDF")
                dayView.layer.borderColor = UIColor(hex: "026CDF").cgColor
                check.image = UIImage(systemName: "checkmark")
                check.tintColor = .systemBlue
                label.textColor = .white
            } else {
                dayView.backgroundColor = .clear
                dayView.layer.borderColor = UIColor(hex: "E5E7EB").cgColor
                check.image = UIImage(systemName: "square")
                check.tintColor = .clear
                label.textColor = .black
            }
        }
    }
    
    func toggleDay(index: Int) {
        if selectedDays.contains(index) {
            selectedDays.remove(index)
            workingTimesByDay[index] = nil
        } else {
            selectedDays.insert(index)
        }
        updateDaysUI()
        tableViewDailyWorking.reloadData()
        tableViewSummary.reloadData()
        updateDaysHeight()
    }
    
    @IBAction func saturdayButton(_ sender: Any) { toggleDay(index: 0) }
    @IBAction func sundayButton(_ sender: Any) { toggleDay(index: 1) }
    @IBAction func mondayButton(_ sender: Any) { toggleDay(index: 2) }
    @IBAction func tuesdayButton(_ sender: Any) { toggleDay(index: 3) }
    @IBAction func wednesdayButton(_ sender: Any) { toggleDay(index: 4) }
    @IBAction func thursdayButton(_ sender: Any) { toggleDay(index: 5) }
    @IBAction func fridayButton(_ sender: Any) { toggleDay(index: 6) }
}

// MARK: - UITableView Delegate & DataSource
extension AvailableAppointmentsViewController: UITableViewDelegate, UITableViewDataSource, DailyWorkingCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedDays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sortedDays = Array(selectedDays).sorted()
        let dayIndex = sortedDays[indexPath.section]   // ← المهم جداً
        
        if tableView == tableViewDailyWorking {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWorkingTableViewCell", for: indexPath) as! DailyWorkingTableViewCell
            cell.dayIndex = dayIndex
            cell.lblDay.text = dayNames[dayIndex]
            cell.array = workingTimesByDay[dayIndex] ?? []
            cell.tableViewDailayTimeWorking.reloadData()
            
            cell.delegate = self
            return cell
            
        } else {  // Summary TableView
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            cell.lblDay.text = dayNames[dayIndex]
            
            if let times = workingTimesByDay[dayIndex], !times.isEmpty {
                let combined = times.map { "\($0.to) - \($0.from)" }.joined(separator: "\n")
                cell.time.text = combined
            } else {
                cell.time.text = "لم يتم اختيار أوقات"
            }
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

    // MARK: - DailyWorkingCellDelegate
    func didUpdateTimes(for dayIndex: Int, times: [DailayTimeItem]) {
        workingTimesByDay[dayIndex] = times
        tableViewSummary.reloadData()
    }
}
