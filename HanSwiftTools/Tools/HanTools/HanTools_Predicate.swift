//
//  HanTools_Predicate.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/13.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

// MARK: - 判断字符串是否为空
/// 判断字符串是否为空
///
/// - Parameter string: 字符串
/// - Returns: true 为空  false 不为空
func EnterStringIsEmpty(string:String?)->Bool{
    
    if string == nil || string == "" {
        return true
    }else if string?.count == 0{
        return true
    }
    return false
}

// MARK: - 判断是否是邮箱
/// 判断是否是邮箱
///
/// - Parameter email: 邮箱
/// - Returns: true 是  false 不是
func EnterIsEmail(email:String?) -> Bool {
    if EnterStringIsEmpty(string: email) {
        return false
    }
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    return predicate(regex: regex, string: email!)
}
// MARK: - 大陆手机号判断
/// 大陆手机号判断
///
/// - Parameter phoneNumber: 手机号
/// - Returns: true 是  false 不是
func EnterIsPhoneNumber(phoneNumber:String?) -> Bool {
    if EnterStringIsEmpty(string: phoneNumber){
        return false
    }
    //    if phoneNumber
    let regex = "^(1[3-9])\\d{9}$"
    return predicate(regex: regex, string: phoneNumber)
}
// MARK: - 香港手机号判断
/// 香港手机号判断
///
/// - Parameter phoneNumber: 手机号
/// - Returns: true 是  false 不是
func EnterIsHKPhoneNumber(phoneNumber:String?) -> Bool {
    if EnterStringIsEmpty(string: phoneNumber){
        return false
    }
    let regex = "^([2-9])\\d{7}$"
    return predicate(regex: regex, string: phoneNumber)
}

// MARK: - 判断是否是8-16位数字和字母
/// 判断是否是8-16位数字和字母
///
/// - Parameter string: 字符串
/// - Returns: true 是  false 不是
func EnterIsNumbersAndLetters8_16(string:String?) -> Bool {
    if EnterStringIsEmpty(string: string) {
        return false
    }
    let regex = "^(?!([a-zA-Z]+|\\d+)$)[a-zA-Z\\d]{8,16}$"
    return predicate(regex: regex, string: string)
}

// MARK: - 判断是否是中英文及数字
/// 判断是否是中英文及数字
///
/// - Parameter string: 字符串
/// - Returns: true 是  false 不是
func EnterIsChineseAndEnglish(string:String?) -> Bool {
    if EnterStringIsEmpty(string: string) {
        return false
    }
    let regex = "[\\u4e00-\\u9fa5a-zA-Z0-9]{4,20}"
    return predicate(regex: regex, string: string)
}

// MARK: - 判断是否是6位数字
/// 判断是否是6位数字
///
/// - Parameter string: 字符串
/// - Returns: true 是  false 不是
func EnterIsSixDigitNumber(string:String?) -> Bool {
    if EnterStringIsEmpty(string: string) {
        return false
    }
    let regex = "^[0-9]{6}$"
    return predicate(regex: regex, string: string)
}

// MARK: - 判断是否是4-20位数字或字母
/// 判断是否是4-20位数字或字母
///
/// - Parameter string: 字符串
/// - Returns: true 是  false 不是
func EnterIsNumbersOrLetters4_20(string:String?) -> Bool {
    if EnterStringIsEmpty(string: string) {
        return false
    }
    let regex = "[0-9a-zA-Z]{4,20}"
    return predicate(regex: regex, string: string)
}

// MARK: - 判断是否是8-20位数字，大写字母和小写字母
/// 判断是否是8-20位数字，大写字母和小写字母
///
/// - Parameter string: 字符串
/// - Returns: true 是  false 不是
func EnterPasswordStyle(string:String?) -> Bool {
    if EnterStringIsEmpty(string: string) {
        return false
    }
    let regex = "(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$"
    return predicate(regex: regex, string: string)
}
//MARK: - 判断是否是包含英文 符号 数字其中两种 8——16位
/// 判断是否是包含英文 符号 数字其中两种
///
/// - Parameter str: 字符串
/// - Returns: true 是  false 不是
func EnterIsNumbersAndLettersAndSymbol8_16(string:String?) -> Bool {
    if EnterStringIsEmpty(string: string) {
        return false
    }
    let regex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"//
    return predicate(regex: regex, string: string)
}
// MARK: - 判断是否符合正则表达式
/// 判断是否符合正则表达式
///
/// - Parameters:
///   - regex: 正则表达式
///   - string: 判断的字符串
/// - Returns: 字符串是否符合正则表达式 true 符合  false 不符合
func predicate(regex:String,string:String?) -> Bool {
    if EnterStringIsEmpty(string: string) {
        return false
    }
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: string)
}
//MARK: - 判断是不是全是空格
/// 判断是不是全是空格
///
/// - Parameter str: 判断的字符串
/// - Returns: true 是  false 不是
func EnterIsAllSpace(str:String?) -> Bool {
    
    if EnterStringIsEmpty(string: str){
        return true
    }
    
    let set = NSCharacterSet.whitespacesAndNewlines
    let trimedString = str?.trimmingCharacters(in: set)
    if trimedString?.count == 0{
        return  true
    }else{
        return  false
    }
    
}

//MARK: - 判断是否含有空格
/// 判断是否含有空格
///
/// - Parameter str: 判断的字符串
/// - Returns: true 是  false 不是
func EnterIsHaveSpace(str:String?) -> Bool {
    
    if EnterStringIsEmpty(string: str){
        return true
    }
    if  (str?.contains(" "))!{
        return true
    }
    return false
}

