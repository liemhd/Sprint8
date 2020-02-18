//
//  AddInfomationViewController.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/14/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class AddInfomationViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var btnNext: UIButton!
    @IBOutlet private weak var btnBack: UIButton!
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var btnIgnore: UIButton!
    @IBOutlet private weak var viewNaviBottom: UIView!
    @IBOutlet private weak var viewPageControl: UIView!
    
    //MARK: - Properties
    private var countPageControl: Int = 0
    private var btnActionNext: CustomButton = CustomButton()
    var callBack: ((_ process: Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupToHideKeyboardOnTapOnView()
        addSubViewInputID()
    }
    
    //MARK: - Function
    private func addSubViewInputID() {
        if let inputIdView = Bundle.main.loadNibNamed(InputYourIDNumberView.name, owner: self, options: nil)?.first as? InputYourIDNumberView {
            inputIdView.frame = viewContent.bounds
            inputIdView.idNumberDelegate = self
            viewContent.addSubview(inputIdView)
        }
    }
    
    private func addSubViewYourAddress() {
        if let yourAddressView = Bundle.main.loadNibNamed(YourAddressView.name, owner: self, options: nil)?.first as? YourAddressView {
            yourAddressView.frame = viewContent.bounds
            viewContent.addSubview(yourAddressView)
        }
    }
    
    private func removeBtnNext() {
        viewNaviBottom.snp.updateConstraints { (make) in
            make.height.equalTo(56)
        }
        
        btnActionNext.removeFromSuperview()
    }
    
    private func addBtnNext(title: String, infoUser: InfoUser?) {
        configBtnNext(title: title, infoUser: infoUser)
        
        viewNaviBottom.snp.updateConstraints { (make) in
            make.height.equalTo(112)
        }
        
        btnActionNext.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalTo(viewNaviBottom).offset(24)
            make.right.equalTo(viewNaviBottom).offset(-24)
            make.bottom.equalTo(viewPageControl.snp.top).offset(0)
        }
    }
    
    private func configBtnNext(title: String, infoUser: InfoUser?) {
        btnActionNext.backgroundColor = .red
        btnActionNext.layer.cornerRadius = 4
        btnActionNext.tintColor = .white
        btnActionNext.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btnActionNext.setTitle(title, for: .normal)
        btnActionNext.infoUser = infoUser
        view.addSubview(btnActionNext)
        btnActionNext.addTarget(self, action: #selector(btnNextClick(_:)), for: .touchUpInside)
    }
    
    private func checkSaveData() {
        if countPageControl == 1 {
            dismiss(animated: true) {
                self.callBack?(66)
            }
        } else {
            dismiss(animated: true) {
                self.callBack?(0)
            }
        }
    }
    
    //MARK: - Action
    @objc private func btnNextClick(_ sender: CustomButton) {
        viewContent.subviews.forEach({$0.removeFromSuperview()})
        btnBack.isHidden = false
        
        switch pageControl.currentPage {
        case 0:
            addSubViewYourAddress()
            removeBtnNext()
            btnNext.isHidden = true
            btnIgnore.isHidden = false
        default:
            break
        }
        
        countPageControl += 1
        pageControl.currentPage = countPageControl
    }
    
    @IBAction private func btnActionClear(_ sender: UIButton) {
        checkSaveData()
    }
    
    @IBAction private func btnActionMore(_ sender: UIButton) {}
    
    @IBAction private func btnActionIgnore(_ sender: UIButton) {
        checkSaveData()
    }
}

extension AddInfomationViewController: SubViewAddInfoDelegate {
    func addBtnNext(isHiddenBtnNext: Bool) {
        if isHiddenBtnNext {
            removeBtnNext()
        } else {
            addBtnNext(title: Constants.next, infoUser: nil)
        }
    }
}
