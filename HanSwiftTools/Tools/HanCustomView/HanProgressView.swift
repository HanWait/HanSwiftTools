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
    
    var type: HantProgressType?{
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
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubView()
        self.updateView()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func addSubView(){
        if self.bgLayer == nil{
            
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
    
    private func updateView(){
        self.lineLayer?.bounds = CGRect.init(x: 0, y: 0, width: self.frame.size.width * self.progress, height: self.frame.size.height)
        switch self.type {
        case .straight?:
            self.lineLayer?.backgroundColor = self.colorArray.first
            break
        case .straightGradient?:
            self.lineLayer?.colors = self.colorArray
            break
        case .circle?:
            self.lineLayer?.colors = self.colorArray
            break
        case .circleGradient?:
            self.lineLayer?.colors = self.colorArray
            break
        default:
            self.lineLayer?.backgroundColor = self.colorArray.first
            break
        }
        self.bgLayer?.backgroundColor = self.bgProgressColor.cgColor
    }
    
    
}
