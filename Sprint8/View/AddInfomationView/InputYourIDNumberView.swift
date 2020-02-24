//
//  InputYourIDNumberView.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/14/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

class InputYourIDNumberView: UIView {
    
    //MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Properties
    var idNumberDelegate: SubViewAddInfoDelegate?

    //MARK: - View Lyfe Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUITableView()
    }
    
    //MARK: - Function
    private func configUITableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 1
        
        tableView.register(UINib(nibName: IdCardTableViewCell.name, bundle: nil), forCellReuseIdentifier: IdCardTableViewCell.name)
        
        tableView.register(UINib(nibName: HeaderView.name, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.name)
    }
}

//MARK: UITableViewDelegate
extension InputYourIDNumberView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.name) as? HeaderView else {
            return nil
        }
        view.setTitleHeader(title: Constants.titleHeaderYourIdNumber, subTitle: Constants.empty)
        
        return view
    }
}

//MARK: UITableViewDataSource
extension InputYourIDNumberView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IdCardTableViewCell.name, for: indexPath) as? IdCardTableViewCell else {
            return UITableViewCell()
        }
        
        cell.callBack = { [weak self] (isHiddenBtnNext: Bool) in
            guard let wSelf = self else {
                return
            }
            
            wSelf.idNumberDelegate?.addBtnNext(isHiddenBtnNext: isHiddenBtnNext)
        }
        
        return cell
    }
}

