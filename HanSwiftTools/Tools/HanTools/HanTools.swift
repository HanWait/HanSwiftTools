//
//  HanTools.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/13.
//  Copyright © 2019 Han. All rights reserved.
//
//  工具类

import UIKit

// MARK: - 获取 文字宽高
/// 获取 文字宽高
///
/// - Parameters:
///   - text: 文字
///   - maxWidth: 最大宽
///   - font: 字体
/// - Returns: 文字宽高
public func getTextSize(text: String, maxWidth: CGFloat,font:UIFont) -> CGRect {
    let maxSize = CGSize(width: maxWidth, height: 0)   //注意高度是0
    let size = text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin,.usesFontLeading],
                                 attributes: [NSAttributedString.Key.font:font], context: nil)
    return size
    
}
// MARK: - 获取 文字高度
/// 获取 文字高度
///
/// - Parameters:
///   - text: 文字
///   - maxHeight: 最大高
///   - font: 字体
/// - Returns: 文字宽高
public func getTextSize(text: String, maxHeight: CGFloat,font:UIFont) -> CGRect {
    let maxSize = CGSize(width: 0, height: maxHeight)   //注意宽度是0
    let size = text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin,.usesFontLeading],
                                 attributes: [NSAttributedString.Key.font:font], context: nil)
    return size
    
}
