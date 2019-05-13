//
//  HanTools_String.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/13.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

extension String{
    
    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    /// 截取字符串
    ///
    /// - Parameter fromIndex: 开始位置
    /// - Returns: 字符串
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    /// 截取字符串
    ///
    /// - Parameter toIndex: 结束位置
    /// - Returns: 字符串
    func substring(toIndex: Int) -> String {
        if toIndex > length {
            return self
        }
        return self[0 ..< max(0, toIndex)]
    }
    
    /// 截取字符串
    ///
    /// - Parameters:
    ///   - fromIndex: 开始位置
    ///   - toIndex: 结束位置
    /// - Returns:
    func substring(fromIndex: Int ,toIndex: Int) -> String {
        return self[min(fromIndex, length) ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    ///删除空格
    func deleteSpace() -> String? {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
}

