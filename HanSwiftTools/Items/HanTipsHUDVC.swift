//
//  HanTipsHUDVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/6/25.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanTipsHUDVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func centerBtnClicked(_ sender: UIButton) {
        
        HanTipsHUD.shared?.show(text: "这是一个提示信息", position: .middle)
        
    }
    @IBAction func bottomBtnClicked(_ sender: UIButton) {
        HanTipsHUD.shared?.show(text: "这是一个提示信息", position: .bottom)
    }
}
