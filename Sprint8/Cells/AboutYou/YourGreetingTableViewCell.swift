//
//  YourGreetingTableViewCell.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/4/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class YourGreetingTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var viewInfoUser: UIView!
    @IBOutlet private weak var imvAvatar: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var imvSelected: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addShadow()
        viewInfoUser.layer.masksToBounds = true
        imvSelected.tintColor = UIColor(hexString: Constants.colorImvSuccess)
    }
    
    func fillData(user: User) {
        imvAvatar.image = user.avatar
        labelName.text = user.name
        if user.isSelected {
            viewInfoUser.borderColor = UIColor(hexString: Constants.borderColorUser)
            imvSelected.isHidden = false
        } else {
            viewInfoUser.borderColor = UIColor.clear
            imvSelected.isHidden = true
        }
    }
}
