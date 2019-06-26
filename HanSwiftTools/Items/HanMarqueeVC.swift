//
//  HanMarqueeVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/6/6.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanMarqueeVC: UIViewController {

    private var marqueeView:HanMarqueeView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        marqueeView = HanMarqueeView.init(frame: CGRect.init(x: 30, y: 100, width: 150, height: 50), content: "我是一个跑马灯,嗯，一个跑马灯！")
        marqueeView.backgroundColor = UIColor.yellow
//        marqueeView.contentFont = UIFont.systemFont(ofSize: 20)
//        marqueeView.contentColor = UIColor.red
        self.view.addSubview(marqueeView)
        
    }
    
    @IBAction func startBtnClicked(_ sender: UIButton) {
        marqueeView.start()
        sender.isUserInteractionEnabled = false
        sender.backgroundColor = UIColor.lightGray
    }
    @IBAction func pauseBtnClicked(_ sender: UIButton) {
        marqueeView.pause()
    }
    @IBAction func resumeBtnClicked(_ sender: UIButton) {
        marqueeView.resume()
    }
    
   
    
    
}
