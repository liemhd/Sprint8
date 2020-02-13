//
//  UIViewController + Extension.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/10/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
