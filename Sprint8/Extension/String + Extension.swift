//
//  String + Extension.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/10/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import Foundation

extension String {
    func validateEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
