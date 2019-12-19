//
//  ExampleVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/10.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class ExampleVC: UIViewController {
    @IBOutlet weak var hanTableView: UITableView!
    var dataArray:[[String:[String]]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            hanTableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.title  = "事例"
        
        
        dataArray = [
           [ "封装系统方法":
                ["相机/相册","网络状态"]],
           ["扩展系统方法":
           ["base64加密",
            "MD5加密",]],
            ["自定义视图":
                ["单图放缩",
                 "多图放缩",
                 "进度条",
                 "跑马灯",
                 "提示信息",]],
            ["自定义方法":
            ["各种正则判断",]]
            
        ]
        
    }
    
    
    
    
}

extension ExampleVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic:Dictionary = self.dataArray[section]
        var arr:[String] = []
        for v in dic.values {
            arr = v
        }
        return arr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dic:Dictionary = self.dataArray[section]
        var title:String = ""
        for v in dic.keys {
            title = v
        }
        return title
                      
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        let dic:Dictionary = self.dataArray[indexPath.section]
        var arr:[String] = []
        for v in dic.values {
            arr = v
        }

        cell?.textLabel?.text = arr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        
        var vc = UIViewController()
        
        switch cell?.textLabel?.text {
        case "相机/相册":
            vc = HanImagePickerVC()
            break
        case "网络状态":
            vc = HanNetworkVC()
            break
        case "单图放缩":
            vc = HanZoomPictureVC()
            break
        case "多图放缩":
            vc = HanZoomPicturesVC()
            break
        case "进度条":
            vc = HanProgressVC()
            break
        case "跑马灯":
            vc = HanMarqueeVC()
            break
        case "提示信息":
            vc = HanTipsHUDVC()
            break
        case "basicVC":
            vc = HanNavVC()
            break
        case "base64加密":
            vc = HanEncryptionVC()
            break
        case "MD5加密":
            vc = HanEncryptionVC()
        break
        default:
            break
        }
        let dic:Dictionary = self.dataArray[indexPath.section]
        var arr:[String] = []
        for v in dic.values {
            arr = v
        }

        vc.title = arr[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



