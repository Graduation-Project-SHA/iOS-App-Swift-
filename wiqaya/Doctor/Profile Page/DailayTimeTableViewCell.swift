//
//  DailayTimeTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/1/25.
//

import UIKit

class DailayTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var backGround: UIView!
    
    @IBOutlet weak var from: UIDatePicker!
    
    @IBOutlet weak var to: UIDatePicker!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
