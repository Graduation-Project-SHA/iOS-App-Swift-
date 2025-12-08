//
//  LanguageTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/8/25.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLanguage: UILabel!
    
    
    @IBOutlet weak var stateLanguageImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with model: LanguageModel, isSelected: Bool) {
        lblLanguage.text = model.language
        
        let imageName = isSelected ? "circle.inset.filled" : "circle"
        stateLanguageImage.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        
        // Colors
        if isSelected {
            stateLanguageImage.tintColor = UIColor(hex: "0094FF")   // اللون المختار
        } else {
            stateLanguageImage.tintColor = UIColor(hex: "9E9E9E")   // اللون غير المختار
        }
    }

}
