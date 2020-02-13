//
//  HomeViewController.swift
//  Sprint8
//
//  Created by Duy Liêm on 2/4/20.
//  Copyright © 2020 DuyLiem. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var isHaveData: Bool = false
    private var infoUser: InfoUser?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func btnActionNext(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let aboutYouVC = sb.instantiateViewController(withIdentifier: AboutYouViewController.name) as? AboutYouViewController else {
            return
        }
        
        aboutYouVC.callBack = { [weak self] (process: Int, isHaveData: Bool, data: InfoUser?) in
            guard let wSelf = self else {
                return
            }
            
            wSelf.isHaveData = isHaveData
            wSelf.infoUser = data
            sender.setTitle("\(process)%", for: .normal)
        }
        
        aboutYouVC.infoUser = infoUser
        present(aboutYouVC, animated: true, completion: nil)
    }
}

