//
//  Pharmaceutical1CollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/30/25.
//

import UIKit

class Pharmaceutical1CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblView: UIView!
    
    @IBOutlet weak var lblMedicine: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "BEDBFF").cgColor

    }

}
