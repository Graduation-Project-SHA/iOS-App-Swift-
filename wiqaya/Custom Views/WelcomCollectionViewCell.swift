//
//  WelcomCollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/18/25.
//

import UIKit

class WelcomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCollectrion: UIImageView!
    
    @IBOutlet weak var labelCollection1: UILabel!
    
    @IBOutlet weak var labelCollection2: UILabel!
    
    @IBOutlet weak var labelView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelView.layer.cornerRadius = 35
    }
}
