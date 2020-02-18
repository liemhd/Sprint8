//
//  Protocol.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/6/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import Foundation

protocol SubViewAboutYouDelegate {
    func addBtnNext(isHiddenBtnNext: Bool, infoUser: InfoUser?)
    func hidenBtnIgnore(infoUser: InfoUser?)
}

protocol SubViewAddInfoDelegate {
    func addBtnNext(isHiddenBtnNext: Bool)
}

protocol AddressDelegate {
    func passDataProvince(province: String)
}
