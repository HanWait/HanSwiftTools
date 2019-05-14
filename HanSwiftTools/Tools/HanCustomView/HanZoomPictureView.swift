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
    
    func show(image:UIImage?){
        self.createImageView(image:image)
        self.addGestureRecognizer()
        
    }
    
    func show(url:String?,placeholderImage:UIImage?){
        self.createImageView(image:placeholderImage ?? UIImage())
        DispatchQueue.global().async {
            let data = NSData.init(contentsOf: URL.init(string: url!)!)
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
                
                
                
                
                self.imageView.bounds = CGRect.init(x: 0, y: 0, width: imaW, height: imaH)
                self.imageView.image = image
                self.addGestureRecognizer()
            }
        }
        
        
    }
    
    private func createImageView(image:UIImage?) {
        
        
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
        imageView.bounds = CGRect.init(x: 0, y: 0, width: imaW, height: imaH)
        imageView.center = CGPoint.init(x: SCREEN_WIDTH/2.0, y: SCREEN_HEIGHT/2.0)
        imageView.image = image
        self.imageView = imageView
        imageView.isUserInteractionEnabled = true
        
        let view = UIApplication.shared.keyWindow?.subviews.first
        
        blackView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        blackView.backgroundColor = .black
        blackView.isUserInteractionEnabled = true
        view?.addSubview(blackView)
        
        blackView.addSubview(imageView)
        
        
        
    }
    
    
    private func addGestureRecognizer() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClicked))
        blackView.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapClicked))
        imageView.addGestureRecognizer(tap1)
        
        
        let pinch = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchGesture(pinch:)))
        imageView.addGestureRecognizer(pinch)
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
