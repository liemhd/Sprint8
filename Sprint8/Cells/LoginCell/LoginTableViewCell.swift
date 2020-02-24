//
//  LoginTableViewCell.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/20/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class LoginTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var viewLogin: UIView!
    @IBOutlet private weak var imvLogoLogin: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var imvLoginSuccess: UIImageView!
    @IBOutlet private weak var btnUnlink: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addShadow()
    }
    
    func fillData(login: User) {
        imvLogoLogin.image = login.avatar
        labelTitle.text = login.name
    }
    
    @IBAction private func btnActionUnlink(_ sender: UIButton) {
    }
}
