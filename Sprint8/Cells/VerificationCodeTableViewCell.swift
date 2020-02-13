//
//  VerificationCodeTableViewCell.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/5/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class VerificationCodeTableViewCell: UITableViewCell {
    
    var callBack: ((_ typeCell: String) -> Void)?
    
    @IBAction func btnActionVerificationCode(_ sender: UIButton) {
        callBack?(Constants.verificationCode)
    }
}
