//
//  HanTipsHUD.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/13.
//  Copyright © 2019 Han. All rights reserved.
//
//  自定义文字提示框
//

import UIKit

class HanTipsHUD: NSObject {
    
    ///显示位置
    enum HanTipsPosition: Int {
        case top
        case middle
        case bottom
    }
    
    ///延迟时间
    var delay: Double = 1.0
    
    //缓存window
    private var bufWindows: [UIWindow] = []
    
    private var blackView:UIView!
    private var backgroundView:UIView!
    private var textLabel:UILabel!

    static var shared:HanTipsHUD? = HanTipsHUD(){
        didSet{
            if shared == nil{
                shared = HanTipsHUD()
            }
        }
    }
    
    
    
    
    /// 展示文字
    ///
    /// - Parameters:
    ///   - text: 要提示的文字
    ///   - position: 位置
    func show(text: String?,position: HanTipsPosition) {
        backgroundView = HanBasicView().getBasicView(backgroundColor: .clear)
        backgroundView.tag = 1008611
        UIApplication.shared.keyWindow?.addSubview(backgroundView)
  
        let size = getTextSize(text: text ?? "", maxWidth: backgroundView.frame.size.width * 0.8, font: UIFont.systemFont(ofSize: scaleWidth(width: 16)))

        blackView = UIView()
        blackView.bounds = CGRect.init(x: 0, y: 0, width: size.width + scaleWidth(width: 20), height: size.height + scaleHeight(height: 20))
        blackView.addLayer(cornerRadius: scaleHeight(height: 10), borderColor: nil, borderWidth: nil)
        blackView.backgroundColor = UIColor().HexColor(hexString: "000000", alpha: 0.6)
        switch position {
        case .top:
            break
        case .middle:
            blackView.center = CGPoint.init(x: backgroundView.frame.size.width * 0.5, y: backgroundView.frame.size.height * 0.5)
            break
        case .bottom:
            break
        }
        backgroundView.addSubview(blackView)
        
        
        
        textLabel = UILabel()
        textLabel.bounds = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        textLabel.center = CGPoint.init(x: blackView.frame.size.width * 0.5, y: blackView.frame.size.height * 0.5)
        textLabel.text = text
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.white
        textLabel.font = UIFont.systemFont(ofSize: scaleWidth(width: 16))
        blackView.addSubview(textLabel)
        
        backgroundView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hide))
        backgroundView.addGestureRecognizer(tap)
        
        perform(#selector(showFinished(sender:)), with: UIApplication.shared.keyWindow!, afterDelay: delay)
        
    }
    
    //toast超时关闭
    @objc func showFinished(sender: AnyObject){
        hide()
    }
    
    /// 消除视图
    @objc private func hide() {
        for view in (UIApplication.shared.keyWindow?.subviews)!{
            if  view.tag == 1008611  {
                view.removeFromSuperview()
                HanTipsHUD.shared = nil
            }
            
        }
        
    }
    
}
