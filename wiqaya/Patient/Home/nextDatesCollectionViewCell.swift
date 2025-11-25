//
//  nextDatesCollectionViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/2/25.
//

import UIKit

class nextDatesCollectionViewCell: UICollectionViewCell {
    let home = HomeViewController()
    @IBOutlet weak var doctorImage: UIImageView!
    
    @IBOutlet weak var nameDoctor: UILabel!
    
    @IBOutlet weak var specialtyDoctor: UILabel!
    
    @IBOutlet weak var clock: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var background: UIImageView!
    
    
    @IBOutlet weak var backGroundDate: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow(for: background, cornerRadius: 20)
        backGroundDate.layer.cornerRadius = 10
        
        nameDoctor.textColor = .white
        specialtyDoctor.textColor = .white
        
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
