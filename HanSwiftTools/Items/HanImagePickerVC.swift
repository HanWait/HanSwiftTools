//
//  HanImagePickerVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/10.
//  Copyright © 2019 Han. All rights reserved.
//
//  调用系统相册
//
import UIKit

class HanImagePickerVC: UIViewController {
    @IBOutlet weak var hanIPImageView: UIImageView!
    private var hanImagePicker:HanImagePicker = HanImagePicker()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        hanIPImageView.addLayer(cornerRadius: 5, borderColor: UIColor.gray, borderWidth: 1)
        hanIPImageView.contentMode = .scaleAspectFill
        
    }

    /// 调用相机/相册点击事件
    @IBAction func takePhotoBtnClicked(_ sender: Any) {
        
        
        weak var this = self
        
        hanImagePicker.showPicker(allowEdit: false, type: .all) { (image) in
            this?.hanIPImageView.image = image
        }
        
    }
    
    /// 保存点击事件  保存图片
    @IBAction func savePhotoBtnClicked(_ sender: Any) {
//        hanImagePicker.saveImage(image: self.hanIPImageView.image,error:)
        hanImagePicker.saveImage(image: self.hanIPImageView.image) { (error) in
            if error != nil{
                HanTipsHUD.shared?.show(text: "保存失败", position: .middle)
            }else{
                HanTipsHUD.shared?.show(text: "保存成功", position: .middle)
            }
        }
    }
    
    /// 图片点击事件  放大图片
    @IBAction func imageViewClicked(_ sender: Any) {
        if self.hanIPImageView.image == nil{
            HanTipsHUD.shared?.show(text: "还没有图片哟~", position: .middle)
        }else{
            HanZoomPictureView.shared?.show(image: self.hanIPImageView.image!)
        }
        
    }
    
}
