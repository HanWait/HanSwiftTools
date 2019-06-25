//
//  HanBasicView.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/13.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanBasicView: NSObject {

    func getBasicView(backgroundColor:UIColor) -> UIView {
        let rootRect = UIApplication.shared.windows.first?.frame   //应用屏幕大小
        let container = UIView()   //全屏且透明，盖在最上面， 可以自定义点击事件， 从而实现模态和非模态框效果。
        container.frame = rootRect!
        container.backgroundColor = backgroundColor
        return container
    }
    
    
    func keyWindow(backgroundColor:UIColor) -> UIView {
        let rootRect = UIApplication.shared.windows.first?.frame   //应用屏幕大小
        let container = UIView()   //全屏且透明，盖在最上面， 可以自定义点击事件， 从而实现模态和非模态框效果。
        container.frame = rootRect!
        container.backgroundColor = backgroundColor
        return container
    }
    
}
