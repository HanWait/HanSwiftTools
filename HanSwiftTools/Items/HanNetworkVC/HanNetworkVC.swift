//
//  HanNetworkVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/12/18.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanNetworkVC: UIViewController,HanNetworkDelegate {
   
    
    var hr :HanReachability?;
    

    @IBOutlet weak var networkLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        hr = HanReachability()
        
        hr?.delegate = self
        
//        hr?.hanNetBlock = {(status) in
//
//            switch status {
//            case .HanWiFi:
//                self.networkLabel.text = "现在使用的是 WiFi"
//                break
//            case .HanWWAN:
//                self.networkLabel.text = "现在使用的是 移动网络"
//                break
//            default:
//                 self.networkLabel.text = "网络状态异常"
//                break
//            }
//
//
//        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hr = nil
    }
    
    func hanNetworkStatus(_ status: HanNetworkStatus) {
           switch status {
           case .HanWiFi:
               self.networkLabel.text = "现在使用的是 WiFi"
               break
           case .HanWWAN:
               self.networkLabel.text = "现在使用的是 移动网络"
               break
           default:
                self.networkLabel.text = "网络状态异常"
               break
           }
    }
    
    deinit {
        print("HanNetworkVC 释放了")
    }

}
