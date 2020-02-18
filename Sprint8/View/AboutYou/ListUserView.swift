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
    var listUserDelegate: SubViewAboutYouDelegate?
    var infoUser: InfoUser? = nil {
        didSet {
            for i in 0..<dataUserArr.count {
                if dataUserArr[i].name == infoUser?.user?.name &&
                    dataUserArr[i].avatar == infoUser?.user?.avatar {
                    dataUserArr[i].isSelected = infoUser?.user?.isSelected ?? false
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
        
        tableView.register(UINib(nibName: YourGreetingTableViewCell.name, bundle: nil), forCellReuseIdentifier: YourGreetingTableViewCell.name)
        
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
        for obj in dataUserArr {
            obj.isSelected = false
        }
        
        dataUserArr[indexPath.row].isSelected = true
        listUserDelegate?.addBtnNext(isHiddenBtnNext: true, infoUser: InfoUser(user: dataUserArr[indexPath.row], inputName: nil, lastName: nil, email: nil))
        
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSource
extension ListUserView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataUserArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YourGreetingTableViewCell.name, for: indexPath) as? YourGreetingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.fillData(user: dataUserArr[indexPath.row])
        
        return cell
    }
}
