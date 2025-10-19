//
//  GradientManager.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/18/25.
//
//
//  GradientManager.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/18/25.
//
//
//  GradientManager.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/18/25.
//

import UIKit

class GradientManager {
    
    /// يضيف تدرّج أزرق ناعم بثلاث درجات (فاتح → متوسط → غامق)
    /// - Parameters:
    ///   - view: الـ UIView اللي هيتطبق عليه التدرّج
    ///   - lightRatio: نسبة الفاتح
    ///   - midRatio: نسبة المتوسط
    ///   - darkRatio: نسبة الغامق
    func applySmoothBlueGradient(
        to view: UIView,
        lightRatio: CGFloat = 0.1,
        midRatio: CGFloat = 0.3,
        darkRatio: CGFloat = 0.6
    ) {
        // إزالة أي تدرجات قديمة
        view.layer.sublayers?
            .filter { $0 is CAGradientLayer }
            .forEach { $0.removeFromSuperlayer() }
        
        // إنشاء التدرّج
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // الألوان: فاتح → متوسط → غامق (0066CC)
        gradientLayer.colors = [
            UIColor(hex: "#6FC8FF").cgColor, // أزرق فاتح جدًا
            UIColor(hex: "#3E9BFF").cgColor, // أزرق متوسط
            UIColor(hex: "#003F80").cgColor  // أزرق عادي/غامق
        ]
        
        // توزيع الألوان (كل رقم يمثل موضع اللون كنسبة من الطول)
        gradientLayer.locations = [
            0.0,                    // بداية الفاتح
            NSNumber(value: Float(lightRatio + midRatio)), // منتصف التدرج
            1.0                     // نهاية الغامق
        ]
        
        // الاتجاه (من أعلى إلى أسفل مائل لليمين)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        // إضافة التدرّج للخلفية
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - UIColor Extension

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
