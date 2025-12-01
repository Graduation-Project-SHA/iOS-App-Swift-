//
//  SummaryTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/1/25.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDay: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var backGround: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backGround.layer.cornerRadius = 10
        backGround.layer.masksToBounds = true
        backGround.layer.borderWidth = 1
        backGround.layer.borderColor = UIColor(hex: "B7CFFB").cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
