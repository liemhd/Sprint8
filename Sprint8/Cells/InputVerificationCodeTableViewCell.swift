//
//  InputVerificationCodeTableViewCell.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/6/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit
import SnapKit

final class InputVerificationCodeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var textFieldVerificationCode: UITextField!
    @IBOutlet private weak var labelResendCode: UILabel!
    @IBOutlet private weak var btnResendCode: UIButton!
    @IBOutlet private weak var labelNotificationCode: UILabel!
    @IBOutlet private weak var viewInputEmail: UIView!
    @IBOutlet weak var labelTime: UILabel!
    
    private var btnVerificationCode: UIButton = UIButton()
    private var timer: Timer?
    private var totalTime: Int = 0
    private var contentCode: String = ""
    var callBack: ((_ typeCell: String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }
    
    private func configUI() {
        textFieldVerificationCode.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configBtnNext() {
        btnVerificationCode.backgroundColor = .red
        btnVerificationCode.layer.cornerRadius = 4
        btnVerificationCode.tintColor = .white
        btnVerificationCode.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btnVerificationCode.setTitle(Constants.verificationEmail, for: .normal)
        self.addSubview(btnVerificationCode)
        btnVerificationCode.addTarget(self, action: #selector(btnNextClick(sender:)), for: .touchUpInside)
    }
    
    private func autolayoutBtnVeriCode() {
        btnVerificationCode.snp.makeConstraints { (make) in
            make.top.equalTo(labelResendCode.snp.bottom).offset(24)
            make.height.equalTo(40)
            make.left.equalTo(self).offset(24)
            make.right.equalTo(self).offset(-24)
        }
        
        btnResendCode.snp.updateConstraints { (make) in
            make.top.equalTo(btnVerificationCode.snp.bottom).offset(32)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count == 6 {
            configBtnNext()
            autolayoutBtnVeriCode()
        }
        
        if textField.text?.count ?? 7 > 6 {
            textField.text = contentCode
            return
        }
        
        contentCode = textField.text ?? Constants.empty
    }
    
    @objc private func btnNextClick(sender: UIButton) {
        if textFieldVerificationCode.text == "111111" {
            viewInputEmail.borderColor = UIColor(hexString: Constants.borderColorTextField)
            labelResendCode.isHidden = true
            callBack?(Constants.emailSucces)
        } else {
            viewInputEmail.borderColor = UIColor(hexString: Constants.borderColorTextFieldFail)
            labelResendCode.isHidden = false
        }
    }
    
    @objc private func onTimerFires() {
        totalTime -= 1
        if totalTime > 0 {
            labelTime.text = totalTime.timeFormatted()
        } else {
            timer?.invalidate()
            timer = nil
            labelTime.text = Constants.resendCode
            btnResendCode.isEnabled = true
        }
    }
    
    @IBAction func btnActionResendCode(_ sender: UIButton) {
        totalTime = Constants.timeResendCode
        labelNotificationCode.isHidden = false
        sender.isEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(onTimerFires),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(timer ?? Timer(), forMode: .common)
    }
}
