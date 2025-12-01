//
//  servicesCollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/2/25.
//

import UIKit

class servicesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myimage: UIImageView!
    
    @IBOutlet weak var mylabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "EDF1F3").cgColor

    }

    
}
