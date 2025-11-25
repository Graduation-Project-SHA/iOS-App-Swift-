//
//  DoctorsChoiceCollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/5/25.
//

import UIKit

class DoctorsChoiceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private let containerView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
