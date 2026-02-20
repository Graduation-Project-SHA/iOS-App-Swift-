//
//  DoctorMapTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 1/24/26.
//

import UIKit

class DoctorMapTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorImage: UIImageView!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var doctorSpecialization: UILabel!
    
    @IBOutlet weak var numberOfRate: UILabel!
    
    @IBOutlet weak var rate: UILabel!
    
    @IBOutlet weak var salary: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
