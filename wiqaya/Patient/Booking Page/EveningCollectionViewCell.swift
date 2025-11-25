//
//  EveningCollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/16/25.
//

import UIKit

class EveningCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var clock: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 12      // الزاوية الدائرية
        layer.masksToBounds = true   // عشان يطبق الـ cornerRadius
        
        layer.borderWidth = 1        // سمك الخط
        layer.borderColor = UIColor.lightGray.cgColor // لون الخط الرمادي
    }

}
