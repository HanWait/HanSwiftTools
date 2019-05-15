//
//  HanImagePicker.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/10.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit
import Photos
/// 调用系统相机相册
class HanImagePicker: NSObject {

    /// 调用系统 相机相册枚举
    enum HanImagePickerType {
        /// 相机
        case camera
        /// 相册
        case album
        /// 相机 相册
        case all
        /// 直接跳转到相机
        case cameraNotTips
        /// 直接跳转到相册
        case albumNotTips
    }
    
    /// 接收相机/相册图片的block
    private var block:HanImageBlock?
    /// 是否允许编辑图片
    private var allowEdit = false
    /// 照片
    private var photograph: UIImage?
    
    /// 保存图片是否成功
    private var saveError:HanErrorBlock?
    /// 加载手机相机相册
    ///
    /// - Parameters:
    ///   - allowEdit: 照片是否可以编辑
    ///   - type: 显示的类型camera: 相机 album: 相册 all: 相机 相册
    ///   - block: 返回的block block内为UIImage
    public func showPicker(allowEdit:Bool,type:HanImagePickerType,block:@escaping HanImageBlock) {
        
        
        self.allowEdit = allowEdit
        self.block = block
        
        if type == .cameraNotTips{
            self.loadUIImagePickerController(type: 2)
            return
        }else if type == .albumNotTips{
            self.loadUIImagePickerController(type: 1)
            return
        }else{
            let aleart = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let albumAction = UIAlertAction.init(title: "从相册选择图片", style: .default) { (action) in
                self.loadUIImagePickerController(type: 1)
            }
            
            let cameraAction = UIAlertAction.init(title: "拍照", style: .default) { (action) in
                self.loadUIImagePickerController(type: 2)
            }
            
            let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
                
            }
            
            switch type {
            case .camera:
                aleart.addAction(cameraAction)
                break
            case .album:
                aleart.addAction(albumAction)
                break
            default:
                aleart.addAction(albumAction)
                aleart.addAction(cameraAction)
                break
            }
            
            aleart.addAction(cancelAction)
            
            HanRootVC?.present(aleart, animated: true, completion: nil)
        }
    }
    
    
    /// 保存传入的图片
    ///
    /// - Parameter image: 图片
    public func saveImage(image:UIImage?,error:HanErrorBlock?){
        self.saveError = error
        if image == nil {
            HanTipsHUD.shared?.show(text: "图片为空", position: .middle)
        }else{
            UIImageWriteToSavedPhotosAlbum(image!, self, #selector(saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
        }
        
    }
    
    /// 保存由相机/相册生成的图片
    public func saveImage(){
        if self.photograph == nil {
            HanTipsHUD.shared?.show(text: "图片为空", position: .middle)
        }else{
            UIImageWriteToSavedPhotosAlbum(self.photograph!, self, #selector(saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
        }
        
    }
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if self.saveError != nil{
            self.saveError!(error)
        }
    }
    
    /// 加载UIImagePickerController
    ///
    /// - Parameter type: 1 相册  2 相机
    private func loadUIImagePickerController(type:Int){
        
        let imagePC = UIImagePickerController()
        imagePC.delegate = self
        if type == 1 {
            let status = PHPhotoLibrary.authorizationStatus()
            if status == .restricted || status == .denied{
                HanTipsHUD.shared?.show(text: "APP访问您的相册受限", position: .middle)
                return
            }else{
                ///相册
                imagePC.sourceType = .photoLibrary
            }
        }else{
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            if status == .restricted || status == .denied{
                HanTipsHUD.shared?.show(text: "APP访问您的相机受限", position: .middle)
                return
            }else{
                ///相机
                imagePC.sourceType = .camera
            }
        }
        imagePC.allowsEditing = self.allowEdit
        HanRootVC?.present(imagePC, animated: true, completion: nil)
        
    }
    
}
extension HanImagePicker:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var photograph = UIImage()
        /// 正常状态下的图片
        let image = info[UIImagePickerController.InfoKey.originalImage]
        /// 编辑状态下的图片
        let imageEdite = info[UIImagePickerController.InfoKey.editedImage]
        if imageEdite != nil{
            photograph = imageEdite as! UIImage
        }else{
            photograph = image as! UIImage
        }
        if self.block != nil {
            self.block!(photograph)
        }
        self.photograph = photograph
        picker.dismiss(animated: true, completion: nil)
    }
}

