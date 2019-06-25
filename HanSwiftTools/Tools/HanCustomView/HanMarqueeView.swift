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

class HanMarqueeView: UIView {
    
    //mLabel1 mLabel2 用于展示跑马灯效果
    private var mLabel1:UILabel?
    private var mLabel2:UILabel?
    /// 放两个label
    private var labelArray:[UILabel?]?
    /// 左侧label的frame
    private var leftFrame:CGRect!
    /// 右侧label的frame
    private var rightFrame:CGRect!
    /// 文字内容
    private var content:String?
    /// 动画是不是停止 true 停  false 动
    private var isStopAnimation:Bool = false
    
    
    
    
    
    /// 文字内容 字体
    var contentFont:UIFont?{
        didSet{
            createSubViews()
        }
    }
    /// 文字内容 颜色
    var contentColor:UIColor?{
        didSet{
            createSubViews()
        }
    }
    
    
    
    
    var durationUnit:CGFloat = 0.2
    var duration:CGFloat = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.createSubViews()
    }

    init(frame: CGRect,content:String?) {
        super.init(frame: frame)
        self.content = content
        duration = CGFloat(content?.count ?? 0) * durationUnit
        self.createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 创建子视图
    private func createSubViews(){
   
//        self.layer.masksToBounds = true
        if EnterStringIsEmpty(string: self.content){
            //内容为空
            print("内容为空")
        }else{
            let textFont = self.contentFont == nil ? UIFont.systemFont(ofSize: 16) : self.contentFont!
            let textColor = self.contentColor == nil ? UIColor.black : self.contentColor!
            let size = getTextSize(text: self.content!, maxHeight: self.height, font: textFont)
            
            
            if self.mLabel1 == nil{
                self.mLabel1 = UILabel()
                self.addSubview(self.mLabel1!)
            }
            
            if size.width <= self.width{
                self.mLabel1?.frame = CGRect.init(x: 0, y: 0, width: size.width, height: self.height)
            }else{
                if self.mLabel2 == nil{
                    self.mLabel2 = UILabel()
                    self.addSubview(self.mLabel2!)
                }
                self.leftFrame = CGRect.init(x: 0, y: 0, width: size.width, height: self.height)
                self.rightFrame = CGRect.init(x: size.width, y: 0, width: size.width, height: self.height)
                
                self.mLabel1?.frame = self.leftFrame
                
                
                self.mLabel2?.frame = self.rightFrame
                self.mLabel2?.text = self.content
                self.mLabel2?.textColor = textColor
                self.mLabel2?.font = textFont
                self.mLabel2?.backgroundColor = .blue
            }
            
            self.mLabel1?.text = self.content
            self.mLabel1?.textColor = textColor
            self.mLabel1?.font = textFont
            self.mLabel1?.backgroundColor = .red
            
            
            self.labelArray = [self.mLabel1,self.mLabel2]
            
            self.marqueeAnimation()
            
        }
        
    }
    
    func start() {
        
        self.marqueeAnimation()
        
        self.isStopAnimation = false
    }
    func stop() {
//        self.mLabel1?.layer.removeAnimation(forKey: "mLabel1")
//        self.mLabel2?.layer.removeAnimation(forKey: "mLabel2")
        
        self.isStopAnimation = true
    }
    
    func pause() {
        
        let pausedTime1 = self.mLabel1?.layer.convertTime(CACurrentMediaTime(), from: nil)
        self.mLabel1?.layer.speed = 0
        self.mLabel1?.layer.timeOffset = pausedTime1 ?? 0
        
        let pausedTime2 = self.mLabel2?.layer.convertTime(CACurrentMediaTime(), from: nil)
        self.mLabel2?.layer.speed = 0
        self.mLabel2?.layer.timeOffset = pausedTime2 ?? 0
        
        self.isStopAnimation = true
    }
    func resume() {
        //当你是停止状态时，则恢复
        if (isStopAnimation) {
            
            
            let pauseTime = self.mLabel1?.layer.timeOffset
            self.mLabel1?.layer.speed = 1.0
            self.mLabel1?.layer.timeOffset = 0
            self.mLabel1?.layer.beginTime = 0
            
            let timeSincePause =  (self.mLabel1?.layer.convertTime(CACurrentMediaTime(), from: nil) ?? 0) - (pauseTime ?? 0)
            self.mLabel1?.layer.beginTime = timeSincePause
            
            
            let pauseTime2 = self.mLabel2?.layer.timeOffset
            self.mLabel2?.layer.speed = 1.0
            self.mLabel2?.layer.timeOffset = 0
            self.mLabel2?.layer.beginTime = 0
            
            let timeSincePause2 =  (self.mLabel2?.layer.convertTime(CACurrentMediaTime(), from: nil) ?? 0) - (pauseTime2 ?? 0)
            self.mLabel2?.layer.beginTime = timeSincePause2
        }
    }
    
    /// 设置动画
    private func marqueeAnimation() {
        
        let lab1 = self.labelArray?[0]
        let lab2 = self.labelArray?[1]
        
        lab1?.layer.removeAnimation(forKey: "mLabel1")
        lab2?.layer.removeAnimation(forKey: "mLabel2")

        let animation1 = CAKeyframeAnimation.init(keyPath: "position")
        animation1.values = [NSValue.init(cgPoint: CGPoint.init(x: (lab1?.frame.origin.x ?? 0) + self.leftFrame.width * 0.5, y: self.frame.size.height * 0.5)),NSValue.init(cgPoint: CGPoint.init(x: ((lab1?.frame.origin.x ?? 0) - self.leftFrame.width * 0.5), y: (self.frame.size.height * 0.5)))]
        animation1.duration = CFTimeInterval(self.duration)
        animation1.calculationMode = .linear
        animation1.isRemovedOnCompletion = false
        animation1.delegate = self
        lab1?.layer.add(animation1, forKey: "mLabel1")
        
        let animation2 = CAKeyframeAnimation.init(keyPath: "position")
        animation2.values = [NSValue.init(cgPoint: CGPoint.init(x: (lab2?.frame.origin.x ?? 0) + self.leftFrame.width * 0.5, y: self.frame.size.height * 0.5)),NSValue.init(cgPoint: CGPoint.init(x: ((lab2?.frame.origin.x ?? 0) - self.leftFrame.width * 0.5), y: (self.frame.size.height * 0.5)))]
        animation2.duration = CFTimeInterval(self.duration)
        animation2.calculationMode = .linear
        animation2.isRemovedOnCompletion = false
        animation2.delegate = self
        lab1?.layer.add(animation2, forKey: "mLabel2")
    }
}
extension HanMarqueeView:CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let lab1 = self.labelArray?[0]
        let lab2 = self.labelArray?[1]
        if flag &&  ((lab1?.layer.animation(forKey: "mLabel1")) != nil){
            lab1?.frame = self.rightFrame
            lab2?.frame = self.leftFrame
            self.labelArray?[0] = lab2
            self.labelArray?[1] = lab1
            self.marqueeAnimation()
        }
    }
}
