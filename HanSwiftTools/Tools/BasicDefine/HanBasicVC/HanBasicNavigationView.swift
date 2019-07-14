//
//  HanBasicNavigationView.swift
//  HanSwiftTools
//
//  Created by Han on 2019/6/26.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanBasicNavigationView: UIView {
    private var bgView:UIView!
    var navImageView:UIImageView!
    var titleLabel:UILabel!
    var rightBtn:UIButton!
    var leftBtn:UIButton!
    
    override init(frame: CGRect) {
         super.init(frame:frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        self.backgroundColor = UIColor.white
        
        navImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height))
        bgView.addSubview(navImageView)
        
        bgView = UIView.init(frame: CGRect.init(x: 0.0, y: kStatusBarHeight, width: self.width, height: kNavBarHeight))
        self.addSubview(bgView)
        
        titleLabel = UILabel.init(frame: .init(x: 50, y: 0, width: bgView.width - 100, height: bgView.height))
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        bgView.addSubview(titleLabel)
        
        leftBtn = UIButton(frame:CGRect(x:0, y:0, width:40, height:bgView.height))
        leftBtn.setImage(UIImage.init(named: "back_icon"), for: .normal)
        leftBtn.titleLabel?.font = titleLabel.font
        bgView.addSubview(leftBtn)
        
        
        rightBtn = UIButton(frame:CGRect(x:bgView.width-40, y:0, width:40, height:bgView.height))
        rightBtn.titleLabel?.font = titleLabel.font
        bgView.addSubview(rightBtn)
        
        
    }
    
}
