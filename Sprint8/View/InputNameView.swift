//
//  InputNameView.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/4/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class InputNameView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataTextField: [TextField] =
        [TextField(tag: 0, title: "Nama depan", placeHolder: "Tulis nama di sini", countCharacter: 20, content: ""),
        TextField(tag: 1, title: "Nama belakang", placeHolder: "Tulis nama di sini", countCharacter: 20, content: "")]
    var inputNameDelegate: SubViewDelegate?
    var infoUser: InfoUser? = nil {
        didSet {
            dataTextField[0].content = infoUser?.inputName
            dataTextField[1].content = infoUser?.lastName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configView()
    }
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 1
        
        tableView.register(UINib(nibName: InputDataTableViewCell.name, bundle: nil), forCellReuseIdentifier: InputDataTableViewCell.name)
        
        tableView.register(UINib(nibName: HeaderView.name, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.name)
    }
}

extension InputNameView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.name) as? HeaderView else {
            return nil
        }
        
        view.setTitleHeader(title: Constants.titleHeaderName, subTitle: Constants.empty)
        
        return view
    }
}

extension InputNameView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTextField.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InputDataTableViewCell.name, for: indexPath) as? InputDataTableViewCell else {
            return UITableViewCell()
        }
        cell.fillData(data: dataTextField[indexPath.row])
        cell.haveData()
        
        if cell.textFieldName.text!.isEmpty {
            inputNameDelegate?.addBtnBeri(isHiddenBtnNext: false, infoUser: nil)
        }
        
        cell.callBack = { [weak self] ( _ ,isEmail: Bool, content: String) in
            guard let wSelf = self else {
                return
            }
            
            wSelf.dataTextField[indexPath.row].content = content
            wSelf.infoUser?.inputName = wSelf.dataTextField[0].content
            wSelf.infoUser?.lastName = wSelf.dataTextField.last?.content
            
            for obj in wSelf.dataTextField {
                if obj.content?.isEmpty ?? true {
                    wSelf.inputNameDelegate?.addBtnBeri(isHiddenBtnNext: false, infoUser: nil)
                    return
                }
            }
            wSelf.inputNameDelegate?.addBtnBeri(isHiddenBtnNext: true, infoUser: wSelf.infoUser)
        }
        
        return cell
    }
}
