//
//  GeneralMedicalRecordViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/8/25.
//

import UIKit

class GeneralMedicalRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    // كل الزيارات (البيانات الخام)
    var array = [GeneralMedicalHistory]()
    
    // البيانات مجمّعة حسب الشهر
    private var sections: [(month: String, items: [GeneralMedicalHistory])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 80
        myTableView.separatorStyle = .none   // مافي خطوط بين الخلايا
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        // تعبئة بيانات تجريبية
        implement()
        
        // تجميع البيانات في سكاشن حسب الشهور
        groupDataByMonth()
    }
    
    // MARK: - بيانات تجريبية
    private func implement() {
        array.append(
            GeneralMedicalHistory(
                date: "26 فبراير",
                lblMainTitle: "تحليل الدم",
                lblSubTitle: """
                خلايا الدم الحمراء: 3.90 مليون خلية/مل
                الهيموجلوبين: 122 جرام/لتر
                الهيماتوكريت: 47.7%
                خلايا الدم البيضاء: 4.300 خلية/مل
                """
            )
        )
        array.append(
            GeneralMedicalHistory(
                date: "24 فبراير",
                lblMainTitle: "تحليل الدم",
                lblSubTitle: """
                   أشعة سينية على الصدر
                """
            )
        )

        array.append(
            GeneralMedicalHistory(
                date: "25 فبراير",
                lblMainTitle: "تحليل الدم",
                lblSubTitle: """
                خلايا الدم الحمراء: 3.90 مليون خلية/مل
                الهيموجلوبين: 122 جرام/لتر
                الهيماتوكريت: 47.7%
                خلايا الدم البيضاء: 4.300 خلية/مل
                """
            )
        )
        
        array.append(
            GeneralMedicalHistory(
                date: "7 يناير",
                lblMainTitle: "تحليل الدم",
                lblSubTitle: """
                خلايا الدم الحمراء: 4.10 مليون خلية/مل
                الهيموجلوبين: 130 جرام/لتر
                """
            )
        )
        
        array.append(
            GeneralMedicalHistory(
                date: "28 يناير",
                lblMainTitle: "تحاليل عامة",
                lblSubTitle: "سكر صائم: 90 مجم/دل"
            )
        )
        array.append(
            GeneralMedicalHistory(
                date: "17 أبريل",
                lblMainTitle: "زيارة طبيب",
                lblSubTitle: "فحص عام ومتابعة"
            )
        )

        array.append(
            GeneralMedicalHistory(
                date: "10 أبريل",
                lblMainTitle: "زيارة طبيب",
                lblSubTitle: "فحص عام ومتابعة"
            )
        )

        array.append(
            GeneralMedicalHistory(
                date: "2 أبريل",
                lblMainTitle: "أشعة",
                lblSubTitle: """
                خلايا الدم الحمراء: 3.90 مليون خلية/مل
                الهيموجلوبين: 122 جرام/لتر
                الهيماتوكريت: 47.7%
                خلايا الدم البيضاء: 4.300 خلية/مل
                """
            )
        )
        
        array.append(
            GeneralMedicalHistory(
                date: "29 أغسطس",
                lblMainTitle: "زيارة طبيب",
                lblSubTitle: "فحص عام ومتابعة"
            )
        )
        array.append(
            GeneralMedicalHistory(
                date: "22 أغسطس",
                lblMainTitle: "أشعة",
                lblSubTitle: """
                خلايا الدم الحمراء: 3.90 مليون خلية/مل
                الهيموجلوبين: 122 جرام/لتر
                الهيماتوكريت: 47.7%
                خلايا الدم البيضاء: 4.300 خلية/مل
                """
            )
        )
        array.append(
            GeneralMedicalHistory(
                date: "5 ديسمبر",
                lblMainTitle: "زيارة طبيب",
                lblSubTitle: "فحص عام ومتابعة"
            )
        )
        array.append(
            GeneralMedicalHistory(
                date: "5 أكتوبر",
                lblMainTitle: "زيارة طبيب",
                lblSubTitle: "فحص عام ومتابعة"
            )
        )
    }
    
    // MARK: - تجميع الداتا حسب الشهر
    private func groupDataByMonth() {
        let monthsOrder = ["يناير","فبراير","مارس","أبريل","مايو","يونيو",
                           "يوليو","أغسطس","سبتمبر","أكتوبر","نوفمبر","ديسمبر"]
        
        // نجمع حسب اسم الشهر
        var dict: [String: [GeneralMedicalHistory]] = [:]
        
        for item in array {
            // نفترض الـ date بالشكل: "25 فبراير"
            let comps = item.date.split(separator: " ")
            guard comps.count >= 2 else { continue }
            let month = String(comps[1])        // "فبراير" مثلاً
            dict[month, default: []].append(item)
        }
        
        // نرتب السكاشن حسب ترتيب الشهور، وما نضيف إلا اللي فيه بيانات
        sections = monthsOrder.compactMap { month in
            if let items = dict[month] {
                return (month: month, items: items)
            } else {
                return nil
            }
        }
        
        myTableView.reloadData()
    }
    
    // MARK: - Navigation Bar & Tab Bar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.title = "السجل الطبي"
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // عنوان السكشن (الشهر) على اليمين
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.text = sections[section].month
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.textAlignment = .right
        label.frame = CGRect(x: 16, y: 5, width: tableView.frame.width - 32, height: 30)
        
        headerView.addSubview(label)
        return headerView
    }
    
    // ارتفاع الهيدر (الشهر)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // مسافة كبيرة بين السكاشن (الشهور)
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25   // كبر/صغر الرقم حسب ما تحب
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GeneralMedicalRecordTableViewCell
        
        let item = sections[indexPath.section].items[indexPath.row]
        
        cell.lblDate.text = item.date
        cell.lblMain.text = item.lblMainTitle
        cell.lblDetails.text = item.lblSubTitle
        let comps = item.date.split(separator: " ")
        let month = comps.count >= 2 ? String(comps[1]) : ""
        
        // الشرط الجديد
        if month == "أغسطس" {
            cell.lblDate.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        } else {
            cell.lblDate.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
        return cell
    }
}

// MARK: - Model

struct GeneralMedicalHistory {
    var date: String        // مثال: "25 فبراير"
    var lblMainTitle: String
    var lblSubTitle: String
}
