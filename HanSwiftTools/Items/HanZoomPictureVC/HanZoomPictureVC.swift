//
//  HanZoomPictureVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/14.
//  Copyright © 2019 Han. All rights reserved.
//
//  放缩单张图片
//

import UIKit

class HanZoomPictureVC: UIViewController {

    @IBOutlet weak var hanZPLocalImageView: UIImageView!
    @IBOutlet weak var hanZPNetworkImageView: UIImageView!
    private let urlString = "http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        hanZPLocalImageView.addLayer(cornerRadius: 5, borderColor: UIColor.gray, borderWidth: 1)
        hanZPNetworkImageView.addLayer(cornerRadius: 5, borderColor: UIColor.gray, borderWidth: 1)
        
        
        ///加载网络图片
        DispatchQueue.global().async {
            let data = NSData.init(contentsOf: URL.init(string: self.urlString)!)
            if data == nil{
                return
            }
            let image = UIImage.init(data: data! as Data)
            
            if image == nil{
                DispatchQueue.main.async {
                }
                return
            }
            DispatchQueue.main.async {
                self.hanZPNetworkImageView.image = image
            }
        }
        
    }
    deinit {
        print("----------释放--------")
    }
    /// 图片点击事件  放大图片
    @IBAction func localImageViewClicked(_ sender: Any) {
        HanZoomPictureView.shared?.show(image: hanZPLocalImageView.image)
    }
    
    /// 图片点击事件  放大图片
    @IBAction func networkImageViewClicked(_ sender: Any) {
        
        HanZoomPictureView.shared?.show(url: urlString, placeholderImage: UIImage.init(named: "placeholder"))
        
    }
}
