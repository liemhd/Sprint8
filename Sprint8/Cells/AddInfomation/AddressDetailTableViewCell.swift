//
//  AddressDetailTableViewCell.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/15/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class AddressDetailTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelCharCount: UILabel!
    @IBOutlet private weak var textFieldAdressDetail: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillData(title: String?) {
        labelTitle.text = title
    }
}
