//
//  HanZoomPictureView.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/13.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanZoomPictureView: NSObject {
    
    static var shared:HanZoomPictureView? = HanZoomPictureView(){
        didSet{
            if shared == nil{
                shared = HanZoomPictureView()
            }
        }
    }
    
    private var image:UIImage = UIImage()
    private var blackView:UIView = UIView()
    private var imageView:UIImageView = UIImageView()
    private var lastScale:CGFloat = 1.0
    
    func showBigImage(image:UIImage?){
        
        
        var imaW = image?.size.width ?? 0.0
        var imaH = image?.size.height ?? 0.0
        
        
        
        if imaW > SCREEN_WIDTH{
            if imaH/imaW <= SCREEN_HEIGHT/SCREEN_WIDTH{
                imaH = imaH/imaW * SCREEN_WIDTH
                imaW = SCREEN_WIDTH
            }else{
                imaW = imaW/imaH * SCREEN_HEIGHT
                imaH = SCREEN_HEIGHT
            }
        }
        
        
        
        let imageView = UIImageView.init()
        imageView.frame = CGRect.init(x: 0, y: 0, width: imaW, height: imaH)
        imageView.center = CGPoint.init(x: SCREEN_WIDTH/2.0, y: SCREEN_HEIGHT/2.0)
        imageView.image = image
        self.imageView = imageView
        imageView.isUserInteractionEnabled = true
        self.createBGView()
        
    }
    
    private func createBGView() {
        
        
        let view = UIApplication.shared.keyWindow
        
        blackView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        blackView.backgroundColor = .black
        blackView.layer.zPosition = 20
        blackView.isUserInteractionEnabled = true
        view?.addSubview(blackView)
        
        blackView.addSubview(imageView)
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClicked))
        blackView.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapClicked))
        imageView.addGestureRecognizer(tap1)
        
        
        let pinch = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchGesture(pinch:)))
        imageView.addGestureRecognizer(pinch)
    }
    
    func showBigImage(imageUrl:String)  {
    
    }
    
    @objc private func tapClicked(){
        self.blackView.removeFromSuperview()
        if HanZoomPictureView.shared != nil{
            HanZoomPictureView.shared = nil
        }
    }
    
    
    @objc private func pinchGesture(pinch:UIPinchGestureRecognizer){
        
        
        if pinch.state == .ended{
            lastScale = 1.0
            return
        }
        
        let scale = 1.0 - (lastScale - pinch.scale)
        let currentTransform = pinch.view?.transform
        let newTransform  = currentTransform?.scaledBy(x: scale, y: scale)
        pinch.view?.transform = newTransform!
        
        self.lastScale = pinch.scale
        
    }
}
