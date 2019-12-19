//
//  HanTipsHUDVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/6/25.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanTipsHUDVC: UIViewController {

    @IBOutlet weak var hanTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func centerBtnClicked(_ sender: UIButton) {
        
        
        HanTipsHUD.shared?.show(text: (hanTF.text?.count ?? 0) != 0  ? hanTF.text : "这是一个提示信息", position: .middle)
        
    }
    @IBAction func bottomBtnClicked(_ sender: UIButton) {
        HanTipsHUD.shared?.show(text: (hanTF.text?.count ?? 0) != 0  ? hanTF.text : "这是一个提示信息", position: .bottom)
    }
}
