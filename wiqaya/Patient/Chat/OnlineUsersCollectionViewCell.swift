//
//  OnlineUsersCollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/25/25.
//

import UIKit

class OnlineUsersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var usersImage: UIImageView!
    
    @IBOutlet weak var greenImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        greenImage.layer.cornerRadius = greenImage.bounds.width / 2
        greenImage.clipsToBounds = true
        usersImage.layer.cornerRadius = usersImage.bounds.width / 2
        usersImage.clipsToBounds = true

    }

    
}
