//
//  DayCollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/16/25.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var dateDay: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = true
        
        // لون عند التحديد
        let selectedView = UIView(frame: bounds)
        selectedView.backgroundColor = UIColor(hex: "#2B73F3")
//        day.textColor = .white
//        dateDay.textColor = .white
        
        self.selectedBackgroundView = selectedView
    }

}
