//
//  MessageCellTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/24/25.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageSender: UIImageView!
    
    @IBOutlet weak var bodyView: UIView!
    
    @IBOutlet weak var lblMsg: UILabel!
    
    @IBOutlet weak var timeSend: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bodyView.layer.cornerRadius = 10
        bodyView.layer.maskedCorners = [
            .layerMinXMinYCorner, // فوق يسار
            .layerMaxXMinYCorner, // فوق يمين
            .layerMaxXMaxYCorner  // تحت يمين
        ]
        bodyView.clipsToBounds = true
        lblMsg.numberOfLines = 0
        
        let maxWidth = UIScreen.main.bounds.width * 0.7  // 70% من عرض الشاشة
        lblMsg.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
