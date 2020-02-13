//
//  NSObject + Extension.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/4/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import Foundation

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
    
    var name: String {
        return String(describing:self)
    }
}
