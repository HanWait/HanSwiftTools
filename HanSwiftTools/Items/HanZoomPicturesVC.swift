//
//  HanZoomPicturesVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/14.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanZoomPicturesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let showView = HanZoomPicturesView.init(frame: CGRect.init(x: 0, y: kTopHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kTopHeight))
        self.view.addSubview(showView)
        
        //        showView.showImagesWithImageURLArray(imageURLArr: ["http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"])
        
        showView.selectIndex = 2
        showView.showImagesWithImageArray(imageArr: [UIImage.init(named: "1") ?? UIImage(),UIImage.init(named: "2") ?? UIImage(),UIImage.init(named: "3") ?? UIImage(),UIImage.init(named: "4") ?? UIImage(),UIImage.init(named: "5") ?? UIImage(),UIImage.init(named: "7") ?? UIImage(),UIImage.init(named: "6") ?? UIImage()])
    }
    
}
