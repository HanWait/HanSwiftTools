//
//  HanNavVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/6/26.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanNavVC: HanBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navView.titleLabel?.text = "好好学习 天天向上  我们都是好孩子 最最善良的孩子"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barStyle = .default
    }

}
