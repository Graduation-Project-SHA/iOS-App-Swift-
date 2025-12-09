//
//  FAQTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/9/25.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    @IBOutlet var heightCell: NSLayoutConstraint!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblAnser: UILabel!
    
    @IBOutlet weak var stateImage: UIImageView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollapsed()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // كل مرة تتعاد استخدامها نرجعها للحالة الإفتراضية
        setupCollapsed()
    }
    // 📌 فانكشن بتجهز الـ cell حسب حالة الموديل
    func configure(with model: FAQModel) {
        lblQuestion.text = model.question
        lblAnser.text = model.answer
        
        if model.isExpanded {
            setupExpanded()
        } else {
            setupCollapsed()
        }
    }
    
    // ✅ حالة مقفولة
    private func setupCollapsed() {
        lblAnser.isHidden = true
        heightCell.constant = 65
        heightCell.isActive = true
        stateImage.image = UIImage(systemName: "chevron.down")
    }
    
    // ✅ حالة مفتوحة
    private func setupExpanded() {
        lblAnser.isHidden = false
        heightCell.isActive = false   // 👈 كده الارتفاع يبقى حسب المحتوى
        stateImage.image = UIImage(systemName: "chevron.up")
    }

}
