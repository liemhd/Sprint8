//
//  InterestsViewController.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/18/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class InterestsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var callBack: ((_ userArr: [User]) -> Void)?
    private var interestsArr: [User] = []
    private var interestSelected:[User] = []
    private var count: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUITableView()
        configDataUI()
    }
    
    //MARK: - Function
    private func configUITableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 1
        
        tableView.register(UINib(nibName: YourGreetingTableViewCell.name, bundle: nil), forCellReuseIdentifier: YourGreetingTableViewCell.name)
        
        tableView.register(UINib(nibName: HeaderView.name, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.name)
    }
    
    private func configDataUI() {
        interestsArr = [
            User(name: "Jalan - jalan", avatar: #imageLiteral(resourceName: "imv_traveling")),
            User(name: "Musik", avatar: #imageLiteral(resourceName: "imv_music")),
            User(name: "Film dan Hiburan", avatar: #imageLiteral(resourceName: "imv_filmAndEntertainment")),
            User(name: "Pendidikan", avatar: #imageLiteral(resourceName: "imv_education")),
            User(name: "Kuliner", avatar: #imageLiteral(resourceName: "imv_culinary_am_thuc")),
            User(name: "Game", avatar: #imageLiteral(resourceName: "imv_game")),
            User(name: "Seni dan Desain", avatar: #imageLiteral(resourceName: "imv_art_and_design")),
            User(name: "Olahraga", avatar: #imageLiteral(resourceName: "imv_sports")),
            User(name: "Gadget", avatar: #imageLiteral(resourceName: "imv_gadget")),
            User(name: "Belanja", avatar: #imageLiteral(resourceName: "imv_shopping"))
        ]
    }
    
    @IBAction private func btnActionClear(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction private func btnActionMore(_ sender: UIButton) {
    }
    
    @IBAction private func btnActionCompleted(_ sender: UIButton) {
        dismiss(animated: true) {
            for obj in self.interestsArr {
                if obj.isSelected {
                    self.interestSelected.append(obj)
                }
            }
            self.callBack?(self.interestSelected)
        }
    }
}

extension InterestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.name) as? HeaderView else {
            return nil
        }
        view.setTitleHeader(title: Constants.chooseMoreThanOne, subTitle: Constants.maxChoose)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if interestsArr[indexPath.row].isSelected {
            interestsArr[indexPath.row].isSelected = false
            count -= 1
        } else {
            if count < 6 {
                interestsArr[indexPath.row].isSelected = true
                count += 1
            }
        }
        tableView.reloadData()
    }
}

extension InterestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YourGreetingTableViewCell.name, for: indexPath) as? YourGreetingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.fillData(user: interestsArr[indexPath.row])
        
        return cell
    }
}
