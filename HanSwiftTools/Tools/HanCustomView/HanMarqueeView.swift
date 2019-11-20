//
//  HanMarqueeView.swift
//  HanSwiftTools
//
//  Created by Han on 2019/6/6.
//  Copyright © 2019 Han. All rights reserved.
//
//  单行 跑马灯效果
//
import UIKit


enum MarqueeType {
    case type1
    case type2
    case type3
    case type4
}

class HanMarqueeView: UIView {
    
    
    /// 运动的总时长
    private var duration:CGFloat = 0
    /// 文字内容
    private var content:String?
    /// 左边的label
    private lazy var leftLabel:UILabel!={
        let lab = UILabel()
        return lab
    }()
    /// 右边的label
    private lazy var rightLabel:UILabel!={
        let lab = UILabel()
        return lab
    }()
    /// 文字内容 字体
    var contentFont:UIFont?{
        didSet{
            self.clearAll()
            self.createSubViews()
        }
    }
    /// 文字内容 字体颜色
    var contentColor:UIColor?{
        didSet{
            leftLabel.textColor = contentColor
            rightLabel.textColor = contentColor
        }
    }
    /// 每个字运动的时长
    var durationUnit:CGFloat = 0.4{
        didSet{
            duration = CGFloat(content?.count ?? 0) * durationUnit
        }
    }
    
    
    init(frame: CGRect,content:String?){
        super.init(frame: frame)
        self.content = content
        duration = CGFloat(content?.count ?? 0) * durationUnit
        self.createSubViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubViews(){
        
        if EnterStringIsEmpty(string: self.content){
            HanTipsHUD.shared?.show(text: "字符串为空", position: .middle)
            print("字符串为空")
            return
        }
        let textFont = self.contentFont == nil ? UIFont.systemFont(ofSize: 16) : self.contentFont!
        let size = getTextSize(text: self.content!, maxHeight: self.height, font: textFont)
        
        
        leftLabel.frame = CGRect.init(x: 0, y: 0, width: size.width, height: self.height)
        leftLabel.text = self.content
        leftLabel.font = textFont
        self.addSubview(leftLabel)
        
        
        rightLabel.frame = CGRect.init(x: size.width, y: 0, width: size.width, height: self.height)
        rightLabel.text = self.content
        rightLabel.font = textFont
        self.addSubview(rightLabel)
        self.layer.masksToBounds = true
    }
    
    
    private func marqueeAnimation(){
        if leftLabel.width <= self.width{
            return
        }
        leftLabel.layer.removeAnimation(forKey: "mLabel1")
        rightLabel.layer.removeAnimation(forKey: "mLabel2")
        
        let animation1 = CAKeyframeAnimation.init(keyPath: "position")
        animation1.values = [
            NSValue.init(cgPoint: CGPoint.init(x: leftLabel.frame.size.width * 0.5, y: leftLabel.frame.size.height  * 0.5)),
            NSValue.init(cgPoint: CGPoint.init(x:  -(leftLabel.frame.size.width * 0.5), y: leftLabel.frame.size.height * 0.5))
        ]
        animation1.duration = CFTimeInterval(self.duration)
        animation1.calculationMode = .linear
        animation1.isRemovedOnCompletion = false
//        animation1.fillMode=CAMediaTimingFillMode.forwards;
        animation1.delegate = self
        leftLabel.layer.add(animation1, forKey: "mLabel1")
        
        let animation2 = CAKeyframeAnimation.init(keyPath: "position")
        animation2.values = [
            NSValue.init(cgPoint: CGPoint.init(x: rightLabel.frame.origin.x + rightLabel.frame.size.width  * 0.5, y: rightLabel.frame.size.height * 0.5)),
            NSValue.init(cgPoint: CGPoint.init(x: rightLabel.frame.size.width * 0.5, y: rightLabel.frame.size.height * 0.5))
        ]
        animation2.duration = CFTimeInterval(self.duration)
        animation2.calculationMode = .linear
        animation2.isRemovedOnCompletion = false
//        animation2.fillMode=CAMediaTimingFillMode.forwards;
        rightLabel.layer.add(animation2, forKey: "mLabel2")
    }
    
    /// 暂停动画
    private func pauseLayer(layer:CALayer){
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0;
        layer.timeOffset = pausedTime
    }
    
    /// 恢复动画
    private func resumeLayer(layer:CALayer){
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0;
        layer.beginTime = 0.0;
        
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    func start() {
        self.marqueeAnimation()
    }
    func pause() {
        self.pauseLayer(layer: self.leftLabel.layer)
        self.pauseLayer(layer: self.rightLabel.layer)
    }
    
    func resume() {
        self.resumeLayer(layer: self.leftLabel.layer)
        self.resumeLayer(layer: self.rightLabel.layer)
    }
    
}
extension HanMarqueeView:CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.marqueeAnimation()
    }
}
