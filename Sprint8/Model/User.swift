//
//  User.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/4/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class User {
    var name: String?
    var avatar: UIImage?
    var isSelected: Bool = false
    
    init(name: String?, avatar: UIImage?, isSelected: Bool = false) {
        self.name = name
        self.avatar = avatar
    }
}
