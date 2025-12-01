//
//  ChatModels.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/25/25.
//

import UIKit

struct message {
    var image: UIImage?
    var sender: String
    var body: String
    var date: Date
}

struct Mymessage {
    var body: String
    var date: Date
    var seen: Bool
}

enum ChatRow {
    case me(Mymessage)
    case other(message)
}
