//
//  MedicalRecordTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/29/25.
//

import UIKit

class MedicalRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var backGround: UIView!
    
    
    @IBOutlet weak var treatmentName: UILabel!
    
    @IBOutlet weak var treatmentStatusView: UIView!
    
    @IBOutlet weak var treatmentStatus: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var appointments: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backGround.layer.cornerRadius = 10
        backGround.clipsToBounds = true
        
        treatmentStatusView.layer.cornerRadius = 10
        treatmentStatusView.clipsToBounds = true
        
        treatmentStatusView.layer.borderWidth = 1
        treatmentStatusView.layer.borderColor = UIColor(hex: "8EC5FF").cgColor
        selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
