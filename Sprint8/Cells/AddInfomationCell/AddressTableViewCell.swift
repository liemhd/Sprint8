//
//  AddressTableViewCell.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/14/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet weak var imvShow: UIImageView!
    @IBOutlet weak var labelProvince: UILabel!
    @IBOutlet weak var btnAddress: UIButton!
    
    private var isSelect: Bool = true
    var tagBtn: Int = 0
    var isSubViewSelected: Bool = false {
        didSet {
            if isSubViewSelected {
                imvShow.image = UIImage(named: "imv_up_arrow")
            } else {
                imvShow.image = UIImage(named: "imv_down_arrow")
            }
        }
    }
    
    var callBack: ((_ isHidden: Bool, _ tag: Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func imvUp() {
        imvShow.image = UIImage(named: "imv_up_arrow")
    }
    
    private func imvDown() {
        imvShow.image = UIImage(named: "imv_down_arrow")
    }
    
    @IBAction private func btnActionListAddress(_ sender: UIButton) {
        if isSelect {
            imvShow.image = UIImage(named: "imv_up_arrow")
            callBack?(false, sender.tag)
            isSelect = false
        } else {
            imvShow.image = UIImage(named: "imv_down_arrow")
            callBack?(true, sender.tag)
            isSelect = true
        }
    }
    
    func fillData(title: String?, province: String?, tag: Int?) {
        labelTitle.text = title
        btnAddress.tag = tag ?? 0
        imvShow.tag = tag ?? 0
        if province != "" {
            labelProvince.textColor = .black
            labelProvince.font = UIFont.boldSystemFont(ofSize: 16)
            labelProvince.text = province
        }
    }
}
