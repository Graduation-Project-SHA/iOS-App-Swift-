//
//  UserData1.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/9/25.
//

import UIKit

class UserData1 {
    static let shared = UserData1()
    
    // هنا نخزّن صورة المريض
    var profileImage: UIImage?
    
    private init() {}
}
