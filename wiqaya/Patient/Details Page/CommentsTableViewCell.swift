//
//  CommentsTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/15/25.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var patientImage: UIImageView!
    
    @IBOutlet weak var patientName: UILabel!
    
    @IBOutlet weak var dateComment: UILabel!
    
    
    
    @IBOutlet weak var rate: UILabel!
    
    @IBOutlet weak var firstStar: UIImageView!
    
    @IBOutlet weak var secondStar: UIImageView!
    
    @IBOutlet weak var thirdStar: UIImageView!
    
    @IBOutlet weak var fourthStar: UIImageView!
    
    
    @IBOutlet weak var fifthStar: UIImageView!
    
    @IBOutlet weak var comment: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    // تابع تحديث النجوم بناءً على الـ rate
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
