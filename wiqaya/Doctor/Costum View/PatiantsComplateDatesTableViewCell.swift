//
//  PatiantsComplateDatesTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/28/25.
//

import UIKit

class PatiantsComplateDatesTableViewCell: UITableViewCell {
    @IBOutlet weak var backGround: UIView!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var clock: UILabel!
    
    @IBOutlet weak var patiantImage: UIImageView!
    
    @IBOutlet weak var patiantName: UILabel!
    
    @IBOutlet weak var consultationType: UILabel!
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow(for: backGround, cornerRadius: 25)
        backGround.layer.masksToBounds = true
        layer.cornerRadius = 20
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setupShadow(for view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 6
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
    }

}
