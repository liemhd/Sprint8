//
//  ProvinceView.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/14/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class ProvinceView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    var provinceDelegate: AddressDelegate?
//    private var heightTableView: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configView()
    }
    
    private func configView() {
        self.addShadow()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setHeightTableView() -> CGFloat {
        var heightOfCell: CGFloat = 0.0
        let cells = tableView.visibleCells
        for cell in cells {
            heightOfCell = cell.frame.height
        }
        return heightOfCell
    }
}

extension ProvinceView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        provinceDelegate?.passDataProvince(province: "\(indexPath.row)")
    }
}

extension ProvinceView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}
