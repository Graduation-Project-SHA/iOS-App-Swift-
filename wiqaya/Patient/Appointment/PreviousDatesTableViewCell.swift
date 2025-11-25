//
//  PreviousDatesTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/20/25.
//

import UIKit

class PreviousDatesTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UIImageView!
    
    
    @IBOutlet weak var doctorimage: UIImageView!
    
    @IBOutlet weak var doctorName: UILabel!
    
    
    @IBOutlet weak var specialty: UILabel!
    
    
    @IBOutlet weak var completedView: UIView!
    
    @IBOutlet weak var cancelView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "CFDFFC").cgColor
        layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
