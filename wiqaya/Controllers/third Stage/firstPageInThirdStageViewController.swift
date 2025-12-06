//
//  firstPageInThirdStageViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/2/25.
//

import UIKit

class firstPageInThirdStageViewController: UIViewController {
    @IBOutlet weak var fistImageView: UIView!
    
    @IBOutlet weak var secondImageView: UIView!
    
    
    @IBOutlet weak var blurimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fistImageView.layer.cornerRadius = 10
        fistImageView.layer.shadowColor = UIColor.black.cgColor
        fistImageView.layer.shadowOpacity = 0.25
        fistImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        fistImageView.layer.shadowRadius = 6
        
        secondImageView.layer.cornerRadius = 10
        secondImageView.layer.shadowColor = UIColor.black.cgColor
        secondImageView.layer.shadowOpacity = 0.25
        secondImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        secondImageView.layer.shadowRadius = 6
        if let currentImage = blurimage.image,
           let blurred = blurImage(currentImage, radius: 10) {
            blurimage.image = blurred
        }
    }
    
    func blurImage(_ image: UIImage, radius: CGFloat = 10) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(radius, forKey: kCIInputRadiusKey)
        
        let context = CIContext()
        
        if let output = filter?.outputImage,
           let cgImage = context.createCGImage(output, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        
        return nil
    }


}
