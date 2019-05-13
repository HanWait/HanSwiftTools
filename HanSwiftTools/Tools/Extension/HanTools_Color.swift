//
//  HanTools_Color.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/13.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit
extension UIColor{
    //MARK: - 颜色 RGB
    
    /// 十进制颜色
    ///
    /// - Parameters:
    ///   - r: 红
    ///   - g: 绿
    ///   - b: 蓝
    /// - Returns: UIColor
    func RGB(r:CGFloat,g:CGFloat,b:CGFloat) ->UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    /// 十进制颜色
    ///
    /// - Parameters:
    ///   - r: 红
    ///   - g: 绿
    ///   - b: 蓝
    ///   - a: 透明度
    /// - Returns: UIColor
    func RGBA(r:CGFloat,g:CGFloat,b:CGFloat, a:CGFloat) ->UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /// 十六进制转颜色
    ///
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 透明度 默认1
    /// - Returns:UIColor
    func HexColor(hexString:String,alpha: CGFloat?) -> UIColor {
        return self.SubHexColor(hexString: hexString, alpha: alpha)
    }
    
    /// 十六进制转颜色
    ///
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    /// - Returns:UIColor
    func HexColor(hexString:String) -> UIColor {
        return self.SubHexColor(hexString: hexString, alpha: 1)
    }
    
    /// 十六进制转颜色
    ///
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 透明度 默认1
    /// - Returns:UIColor
    private func SubHexColor(hexString:String,alpha: CGFloat?) -> UIColor {
        
        //处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        //去掉所有#号 和 空格
        cString = cString.replacingOccurrences(of: "#", with: "")
        cString = cString.replacingOccurrences(of: " ", with: "")
        
        //判断是否符合条件
        if cString.count != 6 {
            return UIColor.white
        }else if predicate(regex: "[0-9a-zA-Z]{6}", string: cString) == false{
            return UIColor.white
        }
        
        //字符串截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        //处理传入的alpha值
        var myAlpha:CGFloat = 1.0
        if alpha != nil{
            if alpha! <= 0.0{
                myAlpha = 0
            }else if alpha! >= 1{
                myAlpha = 1
            }else{
                myAlpha = alpha!
            }
        }else{
            myAlpha = 1
        }
        
        //根据颜色值创建UIColor
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: myAlpha)
    }
    
    ///
    /// 随机颜色
    ///
    /// - Returns: UIColor
    func randomColor() -> UIColor{
        return UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
    }
}

