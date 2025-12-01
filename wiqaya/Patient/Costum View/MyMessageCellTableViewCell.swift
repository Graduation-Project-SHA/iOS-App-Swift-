//
//  MyMessageCellTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/24/25.
//

import UIKit

class MyMessageCellTableViewCell: UITableViewCell {
    @IBOutlet weak var msgView: UIView!
    
    @IBOutlet weak var lblmsg: UILabel!
    
    @IBOutlet weak var sendTime: UILabel!
    
    
    @IBOutlet weak var seenImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        msgView.layer.cornerRadius = 10
        msgView.layer.maskedCorners = [
            .layerMinXMinYCorner, // فوق يسار
            .layerMaxXMinYCorner, // فوق يمين
            .layerMinXMaxYCorner  // تحت يسار
            
        ]
        lblmsg.numberOfLines = 0
        
        let maxWidth = UIScreen.main.bounds.width * 0.7  // 70% من عرض الشاشة
        lblmsg.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true

        msgView.layer.masksToBounds = true   // عشان يطبق الـ cornerRadius

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
