//
//  commentsDoctorCollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/27/25.
//

import UIKit

class commentsDoctorCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backGround: UIView!
    
    @IBOutlet weak var patiantImage: UIImageView!
    
    
    @IBOutlet weak var patiantName: UILabel!
    
    @IBOutlet weak var firstStar: UIImageView!
    
    @IBOutlet weak var secondStar: UIImageView!
    
    @IBOutlet weak var thirdStar: UIImageView!
    
    @IBOutlet weak var fourthStar: UIImageView!
    
    
    @IBOutlet weak var fifthStar: UIImageView!
    
    @IBOutlet weak var lblComments: UILabel!
    
    
    var rate : Double = 0 {
        didSet {
            updateStars(rate: rate)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backGround.layer.cornerRadius = 15
        backGround.layer.masksToBounds = true
        
        backGround.layer.borderWidth = 1
        backGround.layer.borderColor = UIColor(hex: "D2D2D2").cgColor


    }

    func updateStars(rate: Double) {
        let fullStar = "star.fill"
        let halfStar = "star.leadinghalf.fill"
        let emptyStar = "star"
        
        // أضبط حالة كل نجم بناءً على قيمة الـ rate
        let starValues = [
            firstStar,
            secondStar,
            thirdStar,
            fourthStar,
            fifthStar
        ]
        
        // لأن القيمة بين 0 و 5، ممكن نستخدم `rate` لوضع النجوم
        for (index, star) in starValues.enumerated() {
            if rate >= Double(index + 1) {
                // النجمة مكتملة
                star?.image = UIImage(systemName: fullStar)
            } else if rate > Double(index) {
                // النجمة نصف مكتملة
                star?.image = UIImage(systemName: halfStar)
            } else {
                // النجمة فارغة
                star?.image = UIImage(systemName: emptyStar)
            }
        }
    }

}
