//
//  GeneralMedicalRecordTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/9/25.
//

import UIKit

class GeneralMedicalRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblMain: UILabel!
    
    
    @IBOutlet weak var lblDetails: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
