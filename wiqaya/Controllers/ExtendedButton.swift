//
//  ExtendedButton.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/19/25.
//
import UIKit

@IBDesignable
class ExtendedButton: UIButton {
    
    @IBInspectable var extraTouchInset: CGFloat = 20  // توسعة منطقة اللمس
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let largerBounds = bounds.insetBy(dx: -extraTouchInset, dy: -extraTouchInset)
        return largerBounds.contains(point)
    }
}

