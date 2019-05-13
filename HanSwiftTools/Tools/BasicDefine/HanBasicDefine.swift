//
//  HanBasicDefine.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/10.
//  Copyright © 2019 Han. All rights reserved.
//
//  一些基础定义
//
//

import UIKit

//MARK: - 系统的一些控件尺寸
/// 屏幕宽
public let SCREEN_WIDTH  = UIScreen.main.bounds.size.width
/// 屏幕高
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
///状态栏高度
public let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
///导航栏高度
public let kNavBarHeight = 44.0 as CGFloat
///tabbar高度
public let kTabBarHeight = kStatusBarHeight>20 ? 83 : 49
///顶部高度：状态栏高度+导航栏高度
public let kTopHeight = (kStatusBarHeight + kNavBarHeight)
/// keyWindow
public var HanRootVC = UIApplication.shared.keyWindow?.rootViewController

//MARK: - 机型尺寸
/*
 iPhone4s     3.5英寸    320 * 480
 iPhone5      4.0英寸    320 * 568
 iPhone6      4.7英寸    375 * 667
 iPhone6P     5.5英寸    414 * 736
 iPhoneX      5.8英寸    375 * 812
 iPhoneXR     6.1英寸    414 * 896
 iPhoneXMax   6.5英寸    414 * 896
 */

public func IPHONE4() -> Bool{
    if SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 480{
        return true
    }
    return false
}
public func IPHONE5() -> Bool{
    if SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 568{
        return true
    }
    return false
}
public func IPHONE6() -> Bool{
    if SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667{
        return true
    }
    return false
}
public func IPHONEP() -> Bool{
    if SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736{
        return true
    }
    return false
}
public func IPHONEX() -> Bool{
    if SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812{
        return true
    }
    return false
}
public func IPHONEXMax() -> Bool{
    if SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896{
        return true
    }
    return false
}

//MARK: - 缩放比例 以 4.7英寸（375 * 667）为基础比例
/// 比例转换  高
///
/// - Parameter height: 要转换的高
/// - Returns: 转换后的高
func scaleHeight(height:CGFloat) -> CGFloat {
    
    return (SCREEN_HEIGHT/667.0 * height)
}
/// 比例转换  宽
///
/// - Parameter width: 要转换的宽
/// - Returns: 转换后的宽
func scaleWidth(width:CGFloat) -> CGFloat {
    
    return (SCREEN_WIDTH/375.0 * width)
}



