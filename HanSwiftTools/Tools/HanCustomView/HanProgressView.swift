//
//  HanProgressView.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/15.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit


enum HantProgressType {
    case straight
    case straightGradient
    case circle
    case circleGradient
}

class HanProgressView: UIView {
    /// 背景进度条
    private var bgLayer:CALayer?
    /// 进度条
    private var lineLayer:CAGradientLayer?
    
    /// 圆形进度条
    private var circleLayer:CAShapeLayer?
    
    /// 圆形进度条 线宽
    var circleLineWidth:CGFloat = 5.0
    var type: HantProgressType? = .straight{
        didSet{
            self.updateView()
        }
    }
    
    /// 进度条背景颜色  默认是 （230, 244, 245）
    var bgProgressColor: UIColor = UIColor.init(red: 230.0/255.0, green: 244.0/255.0, blue: 245.0/255.0, alpha: 1) {
        didSet{
            self.updateView()
        }
    }
    
    /// 进度条渐变颜色数组，颜色个数>=2  默认是 红 蓝
    var colorArray:[CGColor] = [UIColor.red.cgColor,UIColor.blue.cgColor]{
        didSet{
            self.updateView()
        }
    }
    
    
    /// 进度条 默认0.5
    var progress:CGFloat = 0.5{
        didSet{
            self.updateView()
        }
    }
    
    /// 移动进度条 默认0.5
    var moveProgress:CGFloat = 0.5{
        didSet{
            
            if self.type == .straight || self.type == .straightGradient{
                let count = moveProgress
                self.progress = 0.0
                
                if #available(iOS 10.0, *) {
                    let timer:Timer? = Timer(timeInterval: 0.1, repeats: true) { ( tim) in
                        if self.progress >= count{
                            tim.invalidate()
                            return
                        }
                        self.progress = self.progress + 0.1
                        
                    }
                    RunLoop.current.add(timer!, forMode: .default)
                } else {
                    // Fallback on earlier versions
                    
                }
            }else{
                self.progress = 0
                self.updateView()
                self.circleLayerAnimation()
                
            }
            
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubLayer()
        self.updateView()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubLayer()
        self.updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func addSubLayer(){
        
        self.createBGLayer()
        
        if self.type == .straight || self.type == .straightGradient{
            self.createGradientLayer()
        }else{
            self.createShapeLayer()
        }
        
    }
    
    
    
    private func createBGLayer(){
        if self.bgLayer == nil{
            
            
            if self.bgProgressColor == UIColor.clear{
                self.backgroundColor = self.bgProgressColor
                return
            }
            
            
            let maskLayer = CALayer()
            maskLayer.bounds = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            maskLayer.anchorPoint = CGPoint.init(x: 0, y: 0)
            maskLayer.cornerRadius = self.frame.size.height/2.0
            maskLayer.backgroundColor = self.bgProgressColor.cgColor
            self.layer.mask = maskLayer
            
            self.bgLayer = CALayer()
            self.bgLayer?.bounds = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.bgLayer?.anchorPoint = CGPoint.init(x: 0, y: 0)
            self.bgLayer?.backgroundColor = self.bgProgressColor.cgColor
            self.bgLayer?.cornerRadius = self.frame.size.height/2.0
            self.layer.addSublayer(self.bgLayer!)
        }
    }
    
    
    private func createGradientLayer(){
        if self.lineLayer == nil{
            lineLayer = CAGradientLayer()
            lineLayer?.bounds = CGRect.init(x: 0, y: 0, width: self.frame.size.width * self.progress, height: self.frame.size.height)
            lineLayer?.startPoint = CGPoint.init(x: 0, y: 0 )
            lineLayer?.endPoint = CGPoint.init(x: 1, y: 0)
            lineLayer?.anchorPoint = CGPoint.init(x: 0, y: 0)
            lineLayer?.cornerRadius = self.frame.size.height / 2.0
            self.layer.addSublayer(lineLayer!)
        }
    }
    
    private func createShapeLayer(){
        if self.circleLayer == nil{

            self.backgroundColor = UIColor.clear
            circleLayer = CAShapeLayer()
            circleLayer?.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            circleLayer?.backgroundColor = UIColor.clear.cgColor
            let path = UIBezierPath.init(arcCenter: CGPoint.init(x: self.width * 0.5, y: self.height * 0.5), radius: (self.frame.size.width - self.circleLineWidth)/2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            circleLayer?.path = path.cgPath
            circleLayer?.lineWidth = self.circleLineWidth
            circleLayer?.backgroundColor = UIColor.clear.cgColor
            circleLayer?.fillColor = UIColor.clear.cgColor
            circleLayer?.strokeColor = self.colorArray.first
            circleLayer?.lineCap = .round
            circleLayer?.lineJoin = .round
            circleLayer?.strokeStart = 0.0
            circleLayer?.strokeEnd = self.progress
            self.layer.addSublayer(circleLayer!)
            
            
        }
    }
    
    private func circleLayerAnimation(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = self.moveProgress
        animation.duration = 1.0
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        circleLayer?.add(animation, forKey: "strokeEnd")
        
    }
    
    private func updateView(){
        
        switch self.type {
        case .straight?:
            self.lineLayer?.bounds = CGRect.init(x: 0, y: 0, width: self.frame.size.width * self.progress, height: self.frame.size.height)
            self.lineLayer?.backgroundColor = self.colorArray.first
            self.bgLayer?.backgroundColor = self.bgProgressColor.cgColor
            break
        case .straightGradient?:
            self.lineLayer?.bounds = CGRect.init(x: 0, y: 0, width: self.frame.size.width * self.progress, height: self.frame.size.height)
            self.lineLayer?.colors = self.colorArray
            self.bgLayer?.backgroundColor = self.bgProgressColor.cgColor
            break
        case .circle?:
            circleLayer?.strokeEnd = self.progress
            circleLayer?.strokeColor = self.colorArray.first
            break
        case .circleGradient?:
            self.lineLayer?.colors = self.colorArray
            break
        default:
            self.lineLayer?.backgroundColor = self.colorArray.first
            break
        }
        
    }
    
    
}
