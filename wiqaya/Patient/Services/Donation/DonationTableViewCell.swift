//
//  DonationTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 1/25/26.
//

import UIKit

class DonationTableViewCell: UITableViewCell {

    @IBOutlet weak var donorimage: UIImageView!
    
    @IBOutlet weak var donorName: UILabel!
    
    @IBOutlet weak var donorService: UILabel!
    
    @IBOutlet weak var donorDescription: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
