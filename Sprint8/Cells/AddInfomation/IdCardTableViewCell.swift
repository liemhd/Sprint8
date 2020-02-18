//
//  IdCardTableViewCell.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/14/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class IdCardTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var labelCharCount: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet private weak var lableMaxCharater: UILabel!
    
    private var countCharacter: Int = 16
    private var contentTextField: String = ""
    var callBack: ((_ isHiddenBtnNext: Bool) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }
    
    private func configUI() {
        textFieldName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let countCharacterTextField = textField.text?.count,
            let inputText = textField.text else {
                return
        }
        
        if countCharacter - countCharacterTextField < 0 {
            textField.text = contentTextField
            return
        }
        
        if countCharacterTextField < countCharacter {
            lableMaxCharater.isHidden = false
            callBack?(true)
        } else {
            lableMaxCharater.isHidden = true
            callBack?(false)
        }
        
        contentTextField = inputText
        labelCharCount.text = "\(countCharacter - countCharacterTextField)/\(countCharacter)"
    }
}
