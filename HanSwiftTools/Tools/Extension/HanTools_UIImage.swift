//
//  HanTools_UIImage.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/14.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

extension UIImage{
    
    /// 根据view大小 获取图片Size
    ///
    /// - Parameter view: 展示的view
    /// - Returns: 图片大小
    func getImageSize(view:UIView) -> CGSize {
        var size = CGSize.zero
        
        let sw = view.bounds.size.width
        let sh = view.bounds.size.height
        
        
        if self.size.width <= sw && self.size.height <= sh{
            return self.size
        }else if self.size.width > sw{
            size.width = sw
            size.height = (self.size.height/self.size.width) * sw
        }else if self.size.height > sh{
            size.height = sh
            size.width = (self.size.width/self.size.height) * sh
        }
        return size
    }
}
