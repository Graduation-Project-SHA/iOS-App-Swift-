//
//  WelcomeCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/18/25.
//

import UIKit

class WelcomeCell: UICollectionViewCell {

    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var bottomView: UIView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var msgLabel: UILabel!
    let gradient = GradientManager()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.clipsToBounds = true
    }
    
    func set(item: WelcomeItem) {
        image.image = item.image
        
        titleLabel.text = item.title1
        msgLabel.text = item.title2
    }

}
