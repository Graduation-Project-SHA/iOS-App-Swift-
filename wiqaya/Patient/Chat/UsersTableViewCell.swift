//
//  UsersTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/25/25.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var usersImage: UIImageView!
    
    @IBOutlet weak var usersName: UILabel!
    
    @IBOutlet weak var lastMessage: UILabel!
    
    @IBOutlet weak var timeLastMessage: UILabel!
    
    @IBOutlet weak var newMessageView: UIView!
    
    @IBOutlet weak var numberOfNewMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        usersImage.layer.cornerRadius = usersImage.bounds.width / 2
        usersImage.clipsToBounds = true
        selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
