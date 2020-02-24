//
//  InputEmailView.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/5/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class InputEmailView: UIView {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataTextField: [TextField] = [TextField(tag: 3, title: "Alamat email aktif", placeHolder: "Tulis email di sini", countCharacter: 30, content: "")]
    private var typeCell: String = ""
    var inputEmailDelegate: SubViewAboutYouDelegate?
    var infoUser: InfoUser?
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        configUITableView()
    }
    
    private func configUITableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 1
        
        tableView.register(UINib(nibName: InputDataTableViewCell.name, bundle: nil), forCellReuseIdentifier: InputDataTableViewCell.name)
        
        tableView.register(UINib(nibName: VerificationCodeTableViewCell.name, bundle: nil), forCellReuseIdentifier: VerificationCodeTableViewCell.name)
        
        tableView.register(UINib(nibName: InputVerificationCodeTableViewCell.name, bundle: nil), forCellReuseIdentifier: InputVerificationCodeTableViewCell.name)
        
        tableView.register(UINib(nibName: EmailSuccesTableViewCell.name, bundle: nil), forCellReuseIdentifier: EmailSuccesTableViewCell.name)
        
        tableView.register(UINib(nibName: HeaderView.name, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.name)
    }
}

extension InputEmailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.name) as? HeaderView else {
                return nil
        }
        
        view.setTitleHeader(title: Constants.titleHeaderEmail, subTitle: Constants.empty)
        
        return view
    }
}

extension InputEmailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeCell.isEmpty {
            return dataTextField.count
        } else {
            return dataTextField.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InputDataTableViewCell.name, for: indexPath) as? InputDataTableViewCell else {
                return UITableViewCell()
            }
            
            cell.fillData(data: dataTextField[indexPath.row])
            
            if typeCell == Constants.emailSucces {
                cell.inputTextTrue()
                cell.isEnabledEmail(isEnabled: false)
            } else {
                cell.isEnabledEmail(isEnabled: true)
            }
            
            cell.callBack = { [weak self] (typeCell: String, isEmail: Bool, content: String) in
                guard let wSelf = self else {
                    return
                }
                wSelf.typeCell = typeCell
                wSelf.dataTextField[0].content = content
                
                if !isEmail {
                    if wSelf.tableView.numberOfRows(inSection: 0) > 1 {
                        wSelf.tableView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .none)
                    }
                } else {
                    if wSelf.tableView.numberOfRows(inSection: 0) < 2 {
                        wSelf.tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .none)
                    }
                }
            }
            
            return cell
        default:
            if typeCell == Constants.verificationCode {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: InputVerificationCodeTableViewCell.name, for: indexPath) as? InputVerificationCodeTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.callBack = { [weak self] (typeCell: String) in
                    guard let wSelf = self else {
                        return
                    }
                    
                    wSelf.infoUser?.email = wSelf.dataTextField[0].content
                    wSelf.inputEmailDelegate?.hidenBtnIgnore(infoUser: wSelf.infoUser)
                    wSelf.typeCell = typeCell
                    wSelf.tableView.reloadData()
                }
                
                return cell
            } else if typeCell == Constants.inputEmail {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: VerificationCodeTableViewCell.name, for: indexPath) as? VerificationCodeTableViewCell else {
                    return UITableViewCell()
                }
                cell.callBack = { [weak self] (typeCell: String) in
                    guard let wSelf = self else {
                        return
                    }
                    
                    wSelf.typeCell = typeCell
                    wSelf.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
                }
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EmailSuccesTableViewCell.name, for: indexPath) as? EmailSuccesTableViewCell else {
                    return UITableViewCell()
                }
                
                return cell
            }
        }
    }
}
