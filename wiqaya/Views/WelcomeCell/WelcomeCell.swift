//
//  WelcomeCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/18/25.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var msgLabel: UILabel!
    
    // Slideshow properties
    private var images: [UIImage] = []
    private var currentIndex = 0
    private var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.clipsToBounds = true
    }
    
    // إعداد slideshow
    func setSlideshowImages(_ imgs: [UIImage], title1: String, title2: String) {
        stopSlideshow()
        images = imgs
        currentIndex = 0
        titleLabel.text = title1
        msgLabel.text = title2
        image.image = images.first
        startSlideshow()
    }
    
    // إعداد صورة ثابتة
    func setStaticImage(_ img: UIImage, title1: String, title2: String) {
        stopSlideshow()
        image.image = img
        titleLabel.text = title1
        msgLabel.text = title2
    }
    
    private func startSlideshow() {
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
    }
    
    private func stopSlideshow() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func nextImage() {
        guard !images.isEmpty else { return }
        currentIndex += 1
        if currentIndex >= images.count { currentIndex = 0 }
        
        UIView.transition(with: image, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.image.image = self.images[self.currentIndex]
        }, completion: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopSlideshow()
    }
}
