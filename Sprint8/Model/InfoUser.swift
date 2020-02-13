//
//  InfoUser.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/11/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import Foundation

final class InfoUser: NSObject {
    var user: User?
    var inputName: String?
    var lastName: String?
    var email: String?
    
    deinit {
        print("Deinit")
    }
    
    init(user: User?, inputName: String?, lastName: String?, email: String?) {
        self.user = user
        self.inputName = inputName
        self.lastName = lastName
        self.email = email
    }
}
