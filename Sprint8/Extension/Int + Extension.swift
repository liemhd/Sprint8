//
//  Int + Extension.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/11/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import Foundation

extension Int {
    func timeFormatted() -> String {
        let seconds: Int = self % 60
        let minutes: Int = (self / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
