//
//  HanBase64.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/13.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

/// base64编码
///
/// - Parameter plainString: 要加密的字符串
/// - Returns: 加密后的字符串
func base64Encoding(plainString:String)->String
{
    
    let plainData = plainString.data(using: String.Encoding.utf8)
    let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
    return base64String!
}
/// base64解码
///
/// - Parameter encodedString: 要解密的字符串
/// - Returns: 解密后的字符串
func base64Decoding(encodedString:String)->String
{
    let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
    let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
    return decodedString
}
