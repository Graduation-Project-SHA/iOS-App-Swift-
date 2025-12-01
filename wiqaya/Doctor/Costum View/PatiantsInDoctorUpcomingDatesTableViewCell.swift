//
//  PatiantsInDoctorUpcomingDatesTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/27/25.
//

import UIKit

class PatiantsInDoctorUpcomingDatesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var backGround: UIView!
    
    
    @IBOutlet weak var patiantBookingImage: UIImageView!
    
    @IBOutlet weak var patiantBookingName: UILabel!
    
    @IBOutlet weak var bookingType: UILabel!
    
    @IBOutlet weak var bookingDate: UILabel!
    
    
    @IBOutlet weak var bookingTime: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        backGround.layer.cornerRadius = 10
//        backGround.layer.masksToBounds = true
        selectionStyle = .none
        setupShadow(for: backGround, cornerRadius: 25)
        backGround.layer.masksToBounds = true
        layer.cornerRadius = 20
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
