//
//  HanImagePicker.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/10.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
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
    
    /// 调用相机是否成功
    private var isGetCameraSuccess:Bool = false
    
    /// 调用相册是否成功
    private var isGetAlbumSuccess:Bool = false
    
    
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
            self.checkAlbumPermission(image: image!)
        }
        
    }
    
    /// 保存由相机/相册生成的图片
    public func saveImage(){
        if self.photograph == nil {
            HanTipsHUD.shared?.show(text: "图片为空", position: .middle)
        }else{
            self.checkAlbumPermission(image: self.photograph!)
        }
        
    }
    
    
    private func checkAlbumPermission(image:UIImage){
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == .restricted) {// 这个应用程序未被授权访问图片数据。用户不能更改该应用程序的状态,可能是由于活动的限制,如家长控制到位。
            HanTipsHUD.shared?.show(text: "APP访问您的相册受限", position: .middle)
        }else if(status == .denied){//用户已经明确否认了这个应用程序访问图片数据
            HanTipsHUD.shared?.show(text: "APP访问您的相册受限-->请到设置-->HanSwiftTools-->打开相册", position: .middle)
        }else if status == .notDetermined{// 用户还没有关于这个应用程序做出了选择
            PHPhotoLibrary.requestAuthorization { (sta) in
                if(sta == .authorized){
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
                }
            }
        }else{//authorized 用户授权此应用程序访问图片数据
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
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
            self.isGetAlbumSuccess = false
            self.checkAlbumPermission(imagePC: imagePC)
            if self.isGetAlbumSuccess == false {
                return
            }
        }else{
            self.isGetCameraSuccess = false
            self.checkCameraPermission(imagePC: imagePC)
            if self.isGetCameraSuccess == false {
                return
            }
        }
        
        
    }
    
    private func checkCameraPermission(imagePC:UIImagePickerController){
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        if (status == .restricted) {// 这个应用程序未被授权访问图片数据。用户不能更改该应用程序的状态,可能是由于活动的限制,如家长控制到位。
            HanTipsHUD.shared?.show(text: "APP访问您的相机受限", position: .middle)
            self.isGetCameraSuccess = false
        }else if(status == .denied){//用户已经明确否认了这个应用程序访问图片数据
            HanTipsHUD.shared?.show(text: "APP访问您的相机受限-->请到设置-->HanSwiftTools-->打开相机", position: .middle)
            self.isGetCameraSuccess = false
        }else if status == .notDetermined{// 用户还没有关于这个应用程序做出了选择
            weak var this = self
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if(granted){
                    DispatchQueue.main.async {
                        if(granted){
                            this?.isGetCameraSuccess = true
                            this?.takePhoto(imagePC: imagePC)
                        
                        }
                    }
                    
                }
            }
        }else{//authorized 用户授权此应用程序访问图片数据
            self.isGetCameraSuccess = true
            self.takePhoto(imagePC: imagePC)
        }
        
    }
    
    
    private func takePhoto(imagePC:UIImagePickerController){
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePC.sourceType = .camera
            imagePC.allowsEditing = self.allowEdit
            HanRootVC?.present(imagePC, animated: true, completion: nil)
        }else{
            HanTipsHUD.shared?.show(text: "不能使用模拟器进行拍照", position: .middle)
            self.isGetCameraSuccess = false
        }
        
       
    }
    
    private func checkAlbumPermission(imagePC:UIImagePickerController){
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == .restricted) {// 这个应用程序未被授权访问图片数据。用户不能更改该应用程序的状态,可能是由于活动的限制,如家长控制到位。
            HanTipsHUD.shared?.show(text: "APP访问您的相册受限", position: .middle)
            self.isGetAlbumSuccess = false
        }else if(status == .denied){//用户已经明确否认了这个应用程序访问图片数据
            HanTipsHUD.shared?.show(text: "APP访问您的相册受限-->请到设置-->HanSwiftTools-->打开相册", position: .middle)
            self.isGetAlbumSuccess = false
        }else if status == .notDetermined{// 用户还没有关于这个应用程序做出了选择
            weak var this = self
            PHPhotoLibrary.requestAuthorization { (sta) in
                DispatchQueue.main.async {
                    if(sta == .authorized){
                         this?.isGetAlbumSuccess = true
                        this?.selectAlbum(imagePC: imagePC)
                       
                    }
                }
            }
        }else{//authorized 用户授权此应用程序访问图片数据
            self.isGetAlbumSuccess = true
            self.selectAlbum(imagePC: imagePC)
            
        }
    }
    
    private func selectAlbum(imagePC:UIImagePickerController){
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePC.sourceType = .photoLibrary
            imagePC.allowsEditing = self.allowEdit
            HanRootVC?.present(imagePC, animated: true, completion: nil)
        }
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

