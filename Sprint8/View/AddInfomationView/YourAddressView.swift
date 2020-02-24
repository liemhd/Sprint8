//
//  YourAddressView.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/14/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit
import SnapKit

struct Address {
    var title: String?
    var content: String?
    var tag: Int?
}

final class YourAddressView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    private var addressArr: [Address] = [Address(title: "Pilih provinsi", content: "", tag: 0)]
    private var titleArr: [String] = ["Kabupaten/kota", "Kecamatan", "Kelurahan", "Detil alamat"]
    private var tagArr: [Int] = [1, 2, 3, 4]
    private var province: String = ""
    private var provinceView: ProvinceView?
    private var index: Int = 0
    private var showCountCell: CGFloat = 0
    private var heightProvinceView = 0
    private var tableFooterView: UIView?
    private var isEnableAddress: Bool = true
    private var tagBtn: Int = 0
    
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
        
        tableView.register(UINib(nibName: AddressTableViewCell.name, bundle: nil), forCellReuseIdentifier: AddressTableViewCell.name)
        
        tableView.register(UINib(nibName: AddressDetailTableViewCell.name, bundle: nil), forCellReuseIdentifier: AddressDetailTableViewCell.name)
        
        tableView.register(UINib(nibName: HeaderView.name, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.name)
    }
    
    fileprivate func addFooterView(_ provinceView: ProvinceView, _ showCountCell: CGFloat) {
        tableFooterView  = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: provinceView.setHeightTableView() * showCountCell))
        
        tableFooterView?.backgroundColor = .clear
            tableView.tableFooterView = tableFooterView
    }
    
    fileprivate func removeFooterView() {
        tableFooterView  = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
        
        tableFooterView?.backgroundColor = .clear
        tableView.tableFooterView = tableFooterView
    }
    
    private func addSubViewAddressProvince(cell: AddressTableViewCell, showCountCell: CGFloat) {
        provinceView = Bundle.main.loadNibNamed(ProvinceView.name, owner: self, options: nil)?.first as? ProvinceView
        if let provinceView = provinceView {
            provinceView.provinceDelegate = self
            self.addSubview(provinceView)
            provinceView.snp.updateConstraints { (make) in
                make.top.equalTo(cell.labelProvince.snp.bottom).offset(2)
                make.left.equalTo(self).offset(24)
                make.right.equalTo(self).offset(-24)
                make.height.equalTo(provinceView.setHeightTableView() * showCountCell)
            }
            addFooterView(provinceView, showCountCell)
        }
    }
}

//MARK: UITableViewDelegate
extension YourAddressView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.name) as? HeaderView else {
            return nil
        }
        view.setTitleHeader(title: Constants.titleHeaderYourAddress, subTitle: Constants.empty)
        
        return view
    }
}

//MARK: UITableViewDataSource
extension YourAddressView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case titleArr.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressDetailTableViewCell.name, for: indexPath) as? AddressDetailTableViewCell else {
                return UITableViewCell()
            }
            
            cell.fillData(title: addressArr[indexPath.row].title)
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.name, for: indexPath) as? AddressTableViewCell else {
                return UITableViewCell()
            }
            
            cell.fillData(title: addressArr[indexPath.row].title, province: addressArr[indexPath.row].content, tag: addressArr[indexPath.row].tag)
            
            cell.imvShow.image = UIImage(named: "imv_down_arrow")
            
            cell.callBack = { [weak self] (isHidden: Bool, tag: Int) in
                guard let wSelf = self else {
                    return
                }
                
                cell.isSubViewSelected = false
                for view in cell.subviews {
                    for subView in view.subviews {
                        for imv in subView.subviews {
                            for imv2 in imv.subviews {
                                if imv2 is UIImageView {
                                    let _imv = imv2 as? UIImageView
                                    if tag == _imv?.tag {
                                        cell.isSubViewSelected = true
                                    }
                                }
                            }
                        }
                    }
                }
                
                wSelf.provinceView?.removeFromSuperview()
                
                wSelf.removeFooterView()
                
                if indexPath.row == 0 {
                    wSelf.showCountCell = 10
                } else {
                    wSelf.showCountCell = 6
                }
                
                wSelf.index = indexPath.row
                
                if isHidden {
                    wSelf.provinceView?.removeFromSuperview()
                    cell.imvShow.image = UIImage(named: "imv_down_arrow")
                } else {
                    wSelf.addSubViewAddressProvince(cell: cell, showCountCell: wSelf.showCountCell)
                }
            }
            
            return cell
        }
    }
}

extension YourAddressView: AddressDelegate {
    func passDataProvince(province: String) {
        addressArr[index].content?.removeAll()
        addressArr[index].content?.append(province)
        
        if tagBtn == addressArr[index].tag {
            if addressArr.count < 5 {
                addressArr.append(Address(title: titleArr[index], content: "", tag: tagArr[index]))
                tagBtn += 1
            }
        }
        
        removeFooterView()
        provinceView?.removeFromSuperview()
        provinceView = nil
        tableView.reloadData()
    }
}
