//
//  HanTools_View.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/13.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

extension UIView{
    
    private struct WidthAssociatedKey {
        static var width: CGFloat = 0.0
    }
    
    public var width: CGFloat {
        get {
            
            return objc_getAssociatedObject(self, &WidthAssociatedKey.width) as? CGFloat ?? self.frame.size.width
        }
        
        set {
            objc_setAssociatedObject(self, &WidthAssociatedKey.width, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    private struct HeightAssociatedKey {
        static var height: CGFloat = 0.0
    }
    
    public var height: CGFloat {
        get {
            
            return objc_getAssociatedObject(self, &HeightAssociatedKey.height) as? CGFloat ?? self.frame.size.height
        }
        
        set {
            objc_setAssociatedObject(self, &HeightAssociatedKey.height, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    
    /// 添加圆角
    ///
    /// - Parameters:
    ///   - corners:
    ///   - cornerRadius: 圆角
    func cornerLayer(corners:UIRectCorner?,cornerRadius:CGFloat) {
        if corners == nil {
            return
        }
        var path = UIBezierPath()
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.fillColor = UIColor.white.cgColor
        path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners!, cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
    }
    
    /// 添加圆角
    ///
    /// - Parameters:
    ///   - cornerRadius: 圆角
    ///   - borderColor: 线的颜色
    ///   - borderWidth: 线的宽度
    func addLayer(cornerRadius:CGFloat?,borderColor:UIColor?,borderWidth:CGFloat?) -> Void {
        
        self.layer.masksToBounds = true
        if let cr = cornerRadius {
            self.layer.cornerRadius = cr
        }
        
        if let bc =  borderColor{
            self.layer.borderColor = bc.cgColor
        }
        
        if let bw =  borderWidth{
            self.layer.borderWidth = bw
        }
    }
}
extension UIView {
    
    /// 清楚所有子视图
    func clearAll(){
        
        if self.subviews.count > 0 {
            self.subviews.forEach({ $0.removeFromSuperview()});
        }
        
    }
    
}
