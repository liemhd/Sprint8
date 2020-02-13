//
//  Header.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/13/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet private weak var lableTitle: UILabel!
    @IBOutlet private weak var lableSubTitle: UILabel!
    
    func setTitleHeader(title: String, subTitle: String) {
        lableTitle.text = title
        lableSubTitle.text = subTitle
    }
}
