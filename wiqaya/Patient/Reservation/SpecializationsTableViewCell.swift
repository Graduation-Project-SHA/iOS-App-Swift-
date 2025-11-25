import UIKit

class SpecializationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ear: UIImageView!
    @IBOutlet weak var nameDoctor: UILabel!
    @IBOutlet weak var specializationDoctor: UILabel!
    
    private let containerView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        // إعداد الـ containerView داخل contentView
        contentView.insertSubview(containerView, at: 0)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        containerView.layer.shadowRadius = 5
        containerView.layer.masksToBounds = false
        
        // إعداد الصورة (دائرية)
        ear.contentMode = .scaleAspectFill
        ear.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ear.layer.cornerRadius = ear.frame.size.width / 2
        
        // لازم نحدّث التدرّج لما يتغير حجم الخلية
        if isSelected {
            containerView.applyPrimaryGradient()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        UIView.animate(withDuration: 0.25) {
            if selected {
                // نضيف التدرّج الأزرق عند التحديد
                self.containerView.applyPrimaryGradient()
            } else {
                // نحذف التدرج ونرجع للون الأبيض
                self.containerView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
                self.containerView.backgroundColor = .white
            }
        }
    }
}

extension UIView {
    func applyPrimaryGradient() {
        // نحذف أي تدرجات قديمة
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#4786F5").cgColor,
            UIColor(hex: "#2B73F3").cgColor,
            UIColor(hex: "#3077F3").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
