//
//  AboutYouViewController.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/4/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit
import SnapKit

final class AboutYouViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var btnNext: UIButton!
    @IBOutlet private weak var btnBack: UIButton!
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var btnIgnore: UIButton!
    @IBOutlet private weak var viewNaviBottom: UIView!
    @IBOutlet private weak var viewPageControl: UIView!
    
    //MARK: Properties
    private var countPageControl: Int = 0
    private var btnActionNext: CustomButton = CustomButton()
    private var inputNameSubView: InputNameView?
    var infoUser: InfoUser?
    
    var callBack: ((_ process: Int, _ isHaveData: Bool, _ data: InfoUser?) -> Void)?
    
    //MARK: View Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupToHideKeyboardOnTapOnView()
        addSubViewListUser()
    }
    
    //MARK: Function
    private func addSubViewListUser() {
        if let listUserView = Bundle.main.loadNibNamed(ListUserView.name, owner: self, options: nil)?.first as? ListUserView {
            listUserView.infoUser = infoUser
            listUserView.frame = viewContent.bounds
            listUserView.listUserDelegate = self
            viewContent.addSubview(listUserView)
        }
    }
    
    private func addSubViewInputName() {
        if let inputNameView = Bundle.main.loadNibNamed(InputNameView.name, owner: self, options: nil)?.first as? InputNameView {
            inputNameView.frame = viewContent.bounds
            inputNameView.inputNameDelegate = self
            inputNameView.infoUser = infoUser
            viewContent.addSubview(inputNameView)
        }
    }
    
    private func addSubViewInputEmail() {
        if let inputEmailView = Bundle.main.loadNibNamed(InputEmailView.name, owner: self, options: nil)?.first as? InputEmailView {
            inputEmailView.frame = viewContent.bounds
            inputEmailView.inputEmailDelegate = self
            inputEmailView.infoUser = infoUser
            viewContent.addSubview(inputEmailView)
        }
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
    
    private func removeBtnNext() {
        viewNaviBottom.snp.updateConstraints { (make) in
            make.height.equalTo(56)
        }
        
        btnActionNext.removeFromSuperview()
    }
    
    private func showInfoUser() {
        print(infoUser?.user ?? "")
        print(infoUser?.inputName ?? "")
        print(infoUser?.lastName ?? "")
        print(infoUser?.email ?? "")
    }
    
    //MARK: Action
    @IBAction private func btnActionClear(_ sender: UIButton) {
        if countPageControl == 2 {
            dismiss(animated: true) {
                self.callBack?(66, true, self.infoUser)
                self.showInfoUser()
            }
        } else {
            infoUser = nil
            dismiss(animated: true) {
                self.callBack?(0, false, nil)
                self.showInfoUser()
            }
        }
    }
    
    @IBAction private func btnActionMore(_ sender: UIButton) {}
    
    @IBAction private func btnActionIgnore(_ sender: UIButton) {
        dismiss(animated: true) {
            self.showInfoUser()
        }
    }
    
    @objc private func btnNextClick(_ sender: CustomButton) {
        self.infoUser = sender.infoUser
        viewContent.subviews.forEach({$0.removeFromSuperview()})
        btnBack.isHidden = false
        
        switch pageControl.currentPage {
        case 0:
            addSubViewInputName()
        case 1:
            addSubViewInputEmail()
            btnNext.isHidden = true
            btnIgnore.isHidden = false
        default:
            dismiss(animated: true) {
                self.callBack?(100, true, self.infoUser)
                self.showInfoUser()
            }
        }
        
        countPageControl += 1
        pageControl.currentPage = countPageControl
        
        removeBtnNext()
    }
}

//MARK: - SubViewDelegate
extension AboutYouViewController: SubViewDelegate {
    func hidenBtnIgnore(infoUser: InfoUser?) {
        btnIgnore.isHidden = true
        addBtnNext(title: Constants.completed, infoUser: infoUser)
    }
    
    func addBtnBeri(isHiddenBtnNext: Bool, infoUser: InfoUser?) {
        if isHiddenBtnNext {
            addBtnNext(title: Constants.next, infoUser: infoUser)
        } else {
            removeBtnNext()
        }
    }
}
