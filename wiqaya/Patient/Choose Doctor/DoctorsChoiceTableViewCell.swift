//
//  DoctorsChoiceTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/5/25.
//

import UIKit

class DoctorsChoiceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var nameDoctor: UILabel!
    
    @IBOutlet weak var specialtyDoctor: UILabel!
    
    @IBOutlet weak var priceDoctor: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var chat: UIButton!
    
    
    
    private let containerView = UIView()

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image1.contentMode = .scaleAspectFill
        image1.clipsToBounds = true
        image1.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
