//
//  newBookingsDoctorCollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/27/25.
//

import UIKit

class newBookingsDoctorCollectionViewCell: UICollectionViewCell {
    
    
    let home = HomeViewController()
    @IBOutlet weak var patiantImage: UIImageView!
    
    @IBOutlet weak var namepatiant: UILabel!
    
    @IBOutlet weak var specialtyBooking: UILabel!
    
    @IBOutlet weak var clock: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    
    @IBOutlet weak var backGround: UIView!
    
    
    
    @IBOutlet weak var backGroundDate: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow(for: backGround, cornerRadius: 20)
        backGroundDate.layer.cornerRadius = 10
        backGround.layer.cornerRadius = 15
        backGround.layer.masksToBounds = true

        namepatiant.textColor = .white
        specialtyBooking.textColor = .white

        //        layer.cornerRadius = 20
        //        layer.masksToBounds = false
        //        layer.shadowColor = UIColor.black.cgColor
        //        layer.shadowOpacity = 0.15
        //        layer.shadowOffset = CGSize(width: 0, height: 4)
        //        layer.shadowRadius = 6
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
