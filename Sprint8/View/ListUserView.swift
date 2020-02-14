//
//  ListUserView.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/4/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class ListUserView: UIView {
    
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    private let dataUserArr: [User] = [User(name: "Tuan(Mr.)", avatar: #imageLiteral(resourceName: "imv_user1")),
                                       User(name: "Nyonya(Mrs.)", avatar: #imageLiteral(resourceName: "imv_user2")),
                                       User(name: "Nona(Ms.)", avatar: #imageLiteral(resourceName: "imv_user3"))]
    private var indexSelected: IndexPath?
    var listUserDelegate: SubViewDelegate?
    var infoUser: InfoUser? = nil {
        didSet {
            for i in 0..<dataUserArr.count {
                if dataUserArr[i].name == infoUser?.user?.name &&
                    dataUserArr[i].avatar == infoUser?.user?.avatar {
                    indexSelected = IndexPath(row: i, section: 0)
                }
            }
        }
    }
    
    //MARK: View Lyfe Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUITableView()
    }
    
    //MARK: Function
    private func configUITableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 1
        
        tableView.register(UINib(nibName: TentangAndaTableViewCell.name, bundle: nil), forCellReuseIdentifier: TentangAndaTableViewCell.name)
        
        tableView.register(UINib(nibName: HeaderView.name, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.name)
    }
}

//MARK: UITableViewDelegate
extension ListUserView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.name) as? HeaderView else {
            return nil
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = User(name: dataUserArr[indexPath.row].name, avatar: dataUserArr[indexPath.row].avatar)
        listUserDelegate?.addBtnBeri(isHiddenBtnNext: true, infoUser: InfoUser(user: user, inputName: nil, lastName: nil, email: nil))
        indexSelected = indexPath
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSource
extension ListUserView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataUserArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TentangAndaTableViewCell.name, for: indexPath) as? TentangAndaTableViewCell else {
            return UITableViewCell()
        }
        cell.addShadow()
        cell.fillData(user: dataUserArr[indexPath.row])
        
        cell.isSelecteded(isSelected: false)
        
        if indexPath == indexSelected {
            cell.isSelecteded(isSelected: true)
        }
        
        return cell
    }
}
