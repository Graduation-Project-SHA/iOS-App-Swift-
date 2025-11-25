//
//  ParamedicTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/21/25.
//

import UIKit

class ParamedicTableViewCell: UITableViewCell {

    @IBOutlet weak var hospitalName: UILabel!
    
    
    @IBOutlet weak var hospitalAddress: UILabel!
    
    
    @IBOutlet weak var lblAddressCar: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblDistance: UILabel!
    
    @IBOutlet weak var DetailsOrOrder: UIButton!
    
    
    
    var onButtonTap: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        DetailsOrOrder.tintColor = UIColor(hex: "E7000B")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func DetailsOrOrderButton(_ sender: Any) {
        
        onButtonTap?()

    }
    
    
    
}
