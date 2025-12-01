//
//  DailayTimeTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/1/25.
//

import UIKit

protocol DailayTimeTableViewCellDelegate: AnyObject {
    func didTapDelete(in cell: DailayTimeTableViewCell)
    func didChangeTime(in cell: DailayTimeTableViewCell, from: Date, to: Date)
}

class DailayTimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backGround: UIView!
    @IBOutlet weak var from: UIDatePicker!
    @IBOutlet weak var to: UIDatePicker!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: DailayTimeTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // تصميم الخلفية
        backGround.layer.cornerRadius = 8
        backGround.layer.masksToBounds = true
        
        // إعداد الـ UIDatePickers
        from.datePickerMode = .time
        to.datePickerMode = .time
        
        // الاستماع لتغيير الوقت
        from.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        to.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
    }
    
    // أي تغيير في الوقت يُبلغ delegate
    @objc func timeChanged() {
        delegate?.didChangeTime(in: self, from: from.date, to: to.date)
    }
    
    // زر الحذف
    @IBAction func deleteTapped(_ sender: Any) {
        delegate?.didTapDelete(in: self)
    }
}
