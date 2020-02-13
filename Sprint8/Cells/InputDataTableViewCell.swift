//
//  InputDataTableViewCell.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/4/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class InputDataTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelCharCount: UILabel!
    @IBOutlet private weak var textFieldName: UITextField!
    @IBOutlet private weak var viewName: UIView!
    @IBOutlet private weak var imvTick: UIImageView!
    @IBOutlet private weak var lableMaxCharater: UILabel!
    
    private var countCharacter: Int = 0
    private var contentTextField: String = ""
    var callBack: ((_ typeCell: String, _ isEmail: Bool, _ content: String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }
    
    private func configUI() {
        viewName.layer.masksToBounds = true
        imvTick.tintColor = UIColor(hexString: Constants.colorImvSuccess)
        textFieldName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    func isEnabledEmail(isEnabled: Bool) {
        if !isEnabled {
            textFieldName.isEnabled = false
        } else {
            textFieldName.isEnabled = true
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let countCharacterTextField = textField.text?.count,
                let inputText = textField.text else {
            return
        }
        if textField.tag == 0 || textField.tag == 1 {
            if countCharacter - countCharacterTextField < 0 {
                labelCharCount.textColor = .red
                textField.text = contentTextField
                lableMaxCharater.isHidden = false
                inputTextFail()
                return
            }
            
            if inputText.isEmpty {
                labelCharCount.text = "\(countCharacter - countCharacterTextField)/\(countCharacter)"
                inputTextFail()
                return
            }
            
            inputTextTrue()
            callBack?(Constants.inputEmail, true, inputText)
        } else {
            if countCharacter - countCharacterTextField < 0 {
                labelCharCount.textColor = .red
                textField.text = contentTextField
                return
            }
            if inputText.validateEmail() {
                callBack?(Constants.inputEmail, true, inputText)
            } else {
                callBack?("", false, "")
            }
            
        }
        
        contentTextField = textField.text ?? Constants.empty
        labelCharCount.text = "\(countCharacter - countCharacterTextField)/\(countCharacter)"
        
    }
    
    func inputTextTrue() {
        guard let countText = textFieldName.text?.count else {
            return
        }
        labelCharCount.text = "\(countCharacter - countText)/\(countCharacter)"
        labelCharCount.textColor = UIColor(hexString: Constants.colorCountCharacter)
        viewName.borderColor = UIColor.green
        imvTick.isHidden = false
        lableMaxCharater.isHidden = true
    }
    
    private func inputTextFail() {
        viewName.borderColor = UIColor(hexString: Constants.borderColorTextField)
        imvTick.isHidden = true
        callBack?("", false, "")
    }
    
    func fillData(data: TextField) {
        labelTitle.text = data.title
        textFieldName.tag = data.tag ?? 0
        textFieldName.placeholder = data.placeHolder
        countCharacter = data.countCharacter ?? 0
        labelCharCount.text = "\(countCharacter)/\(countCharacter)"
    }
}
