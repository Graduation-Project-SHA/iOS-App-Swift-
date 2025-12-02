//
//  DailyWorkingTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/1/25.
//

import UIKit

protocol DailyWorkingCellDelegate: AnyObject {
    func didUpdateTimes(for dayIndex: Int, times: [DailayTimeItem])
}

class DailyWorkingTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var backGround: UIView!
    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var tableViewDailayTimeWorking: UITableView!
    
    @IBOutlet weak var heightTime: NSLayoutConstraint!
    var array = [DailayTimeItem]()
    var dayIndex: Int = 0
    weak var delegate: DailyWorkingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableViewDailayTimeWorking.delegate = self
        tableViewDailayTimeWorking.dataSource = self
        tableViewDailayTimeWorking.estimatedRowHeight = 80
        tableViewDailayTimeWorking.rowHeight = UITableView.automaticDimension
        
        backGround.layer.cornerRadius = 10
        backGround.layer.masksToBounds = true
        backGround.layer.borderWidth = 1
        backGround.layer.borderColor = UIColor(hex: "E5E7EB").cgColor

    }
    
    @IBAction func addTapped(_ sender: Any) {
        // إضافة وقت افتراضي
        let now = Date()
        let plusOne = Calendar.current.date(byAdding: .hour, value: 1, to: now)!
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let newItem = DailayTimeItem(from: formatter.string(from: now),
                                     to: formatter.string(from: plusOne))
        array.append(newItem)
        tableViewDailayTimeWorking.reloadData()
        delegate?.didUpdateTimes(for: dayIndex, times: array)
    }
    
    // MARK: - UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailayTimeTableViewCell", for: indexPath) as! DailayTimeTableViewCell
        
        let item = array[indexPath.section]   // ← المهم
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        if let fromDate = formatter.date(from: item.from) {
            cell.from.date = fromDate
        }
        if let toDate = formatter.date(from: item.to) {
            cell.to.date = toDate
        }
        
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1   // تقدر تغيّرها حسب ما يعجبك
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

// MARK: - DailayTimeTableViewCellDelegate
extension DailyWorkingTableViewCell: DailayTimeTableViewCellDelegate {
    func didTapDelete(in cell: DailayTimeTableViewCell) {
        guard let indexPath = tableViewDailayTimeWorking.indexPath(for: cell) else { return }
        
        array.remove(at: indexPath.section)
        
        tableViewDailayTimeWorking.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        
        delegate?.didUpdateTimes(for: dayIndex, times: array)
    }

    func didChangeTime(in cell: DailayTimeTableViewCell, from: Date, to: Date) {
        guard let indexPath = tableViewDailayTimeWorking.indexPath(for: cell) else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        array[indexPath.section].from = formatter.string(from: from)
        array[indexPath.section].to = formatter.string(from: to)
        delegate?.didUpdateTimes(for: dayIndex, times: array)
    }
}
