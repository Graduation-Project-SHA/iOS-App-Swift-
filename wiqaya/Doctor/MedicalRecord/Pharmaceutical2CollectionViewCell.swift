//
//  Pharmaceutical2CollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/30/25.
//

import UIKit

class Pharmaceutical2CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblView: UIView!
    
    @IBOutlet weak var lblMedicine: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true

    }

}
