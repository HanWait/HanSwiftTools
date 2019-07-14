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
    var dataArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            hanTableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.title  = "事例"
        dataArray = ["相机/相册",
                     "单图放缩",
                     "多图放缩",
                     "进度条",
                     "跑马灯",
                     "提示信息",
                     "basicVC"]
        
    }
    
    
    
    
}

extension ExampleVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = self.dataArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        
        var vc = UIViewController()
        
        switch cell?.textLabel?.text {
        case "相机/相册":
            vc = HanImagePickerVC()
            vc.title = "相机/相册"
            break
        case "单图放缩":
            vc = HanZoomPictureVC()
            vc.title = "单图放缩"
            break
        case "多图放缩":
            vc = HanZoomPicturesVC()
            vc.title = "多图放缩"
            break
        case "进度条":
            vc = HanProgressVC()
            vc.title = "进度条"
            break
        case "跑马灯":
            vc = HanMarqueeVC()
            vc.title = "跑马灯"
            break
        case "提示信息":
            vc = HanTipsHUDVC()
            vc.title = "提示信息"
        case "basicVC":
            vc = HanNavVC()
        default:
            break
        }
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
