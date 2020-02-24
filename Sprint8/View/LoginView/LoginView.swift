//
//  LoginView.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/20/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit
import FBSDKLoginKit

final class LoginView: UIView {
    
    //MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Properties
    private var loginArr: [User] = []
    private var publicProfile = ["id", "first_name", "last_name", "middle_name", "name", "name_format", "picture", "short_name"]
    
    //MARK: - View Lyfe Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUITableView()
        configDataUI()
    }
    
    private func configDataUI() {
        loginArr = [
            User(name: "Facebook", avatar: #imageLiteral(resourceName: "imv_fb")),
            User(name: "Twitter", avatar: #imageLiteral(resourceName: "imv_twitter")),
            User(name: "Instagram", avatar: #imageLiteral(resourceName: "imv_instagram")),
            User(name: "TikTok", avatar: #imageLiteral(resourceName: "imv_tiktok")),
            User(name: "Google", avatar: #imageLiteral(resourceName: "imv_google"))
        ]
    }
    
    //MARK: - Function
    private func configUITableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 1
        
        tableView.register(UINib(nibName: LoginTableViewCell.name, bundle: nil), forCellReuseIdentifier: LoginTableViewCell.name)
        
        tableView.register(UINib(nibName: HeaderView.name, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.name)
    }
}

//MARK: UITableViewDelegate
extension LoginView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.name) as? HeaderView else {
            return nil
        }
        view.setTitleHeader(title: Constants.titleHeaderLogin, subTitle: Constants.subTitleHeaderLogin)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let manager = LoginManager()
        manager.logIn(permissions: ["name"], from: AboutYouViewController()) { (result, error) in
            if error == nil {
                print("Login success!")
            } else {
                print(error)
            }
        }
    }
}

//MARK: UITableViewDataSource
extension LoginView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoginTableViewCell.name, for: indexPath) as? LoginTableViewCell else {
            return UITableViewCell()
        }
        
        cell.fillData(login: loginArr[indexPath.row])
        
        return cell
    }
}
