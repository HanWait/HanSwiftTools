//
//  HanEncryptionVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/12/12.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanEncryptionVC: UIViewController {

    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var hanTF: UITextField!
    @IBOutlet weak var hanTV: UITextView!
    @IBOutlet weak var hanTV2: UITextView!
    @IBOutlet weak var hanTV3: UITextView!
    @IBOutlet weak var btn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        /*
         由于 是扩展了系统的string方法 所以直接  string.方法  调用即可
         base64:
         

         */
        
        
        self.loadUI()
    }
    
    
    func loadUI() {
        self.hanTV.isEditable = false;
        self.hanTV3.isEditable = false;
        
        self.hanTV.placeholder = "base64 字符串"
        self.hanTV2.placeholder = "base64 字符串"
        self.hanTV3.placeholder = "字符串"
        
        self.hanTV.addLayer(cornerRadius: 5, borderColor: UIColor.black, borderWidth: 1)
        self.hanTV2.addLayer(cornerRadius: 5, borderColor: UIColor.black, borderWidth: 1)
        self.hanTV3.addLayer(cornerRadius: 5, borderColor: UIColor.black, borderWidth: 1)
        
        
        if (self.title == "MD5加密"){
            self.btn2.isHidden = true
            self.hanTV2.isHidden = true
            self.hanTV3.isHidden = true
            self.titleLabel2.isHidden = true
            self.hanTV.placeholder = "MD5 字符串"
            self.titleLabel1.text = "MD5加密"
        }
    }

    @IBAction func sureBtnClicked(_ sender: UIButton) {
        
        
        if (self.title == "MD5加密") {
            if ((self.hanTF?.text) != nil) {
                self.hanTV.text = self.hanTF.text?.md5
                self.hanTV.placeholder = ""
            }
        }else{
            if ((self.hanTF?.text) != nil) {
                self.hanTV.text = self.hanTF.text?.base64Encoding
                self.hanTV.placeholder = ""
            }
        }
        
    }
    
    @IBAction func sureBtn2Clicked(_ sender: UIButton) {
        
        if ((self.hanTV2?.text) != nil) {
            self.hanTV3.text = self.hanTV2.text?.base64Decoding
            self.hanTV3.placeholder = ""
        }
        
        
    }
    
    
    

}

#warning("以下方式仅支持textView手动输入内容 改变placeholder")
extension UITextView {
    
    private struct RuntimeKey {
        static let hw_placeholderLabelKey = UnsafeRawPointer.init(bitPattern: "hw_placeholderLabelKey".hashValue)
        /// ...其他Key声明
    }

    /// 占位文字y值调整
    @IBInspectable public var placeholderY: CGFloat {
        get {
            return placeholderLabel.frame.origin.y
        }
        set {
            self.placeholderLabel.frame = CGRect(x: placeholderLabel.frame.origin.x, y: newValue, width: placeholderLabel.frame.size.width, height: placeholderLabel.frame.size.height)
            self.setNeedsLayout()
        }
    }
    /// 占位文字
    @IBInspectable public var placeholder: String {
        get {
            return self.placeholderLabel.text ?? ""
        }
        set {
            let attributedText = NSMutableAttributedString(string: newValue)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3 // 别问为啥是3 我也不知道看着像而已
            style.lineBreakMode = .byCharWrapping
            attributedText.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0,newValue.count))
            placeholderLabel.attributedText = attributedText
            refreshPlaceholder()
        }
    }
    /// 占位文字颜色
    @IBInspectable public var placeholderColor: UIColor {
        get {
            return placeholderLabel.textColor
        }
        set {
            placeholderLabel.textColor = newValue
        }
    }
    
    private var placeholderLabel: UITextViewPlaceholderLabel {
        get {
            var label = objc_getAssociatedObject(self, UITextView.RuntimeKey.hw_placeholderLabelKey!) as? UITextViewPlaceholderLabel
            if label == nil { // 不存在是 创建 绑定
                if (font == nil) { // 防止没大小时显示异常 系统默认设置14
                    font = UIFont.systemFont(ofSize: 14)
                }
                let width = bounds.width-10
                let y: CGFloat = 8
                let x: CGFloat = 6
                let frame = CGRect(x: x, y: y, width: width, height: bounds.size.height-y*2) // 别问为啥是这些数字 看着位置对然后就这样了
                label = UITextViewPlaceholderLabel.init(frame: frame)
                label?.numberOfLines = 0
                label?.font = font
                label?.textColor = UIColor.lightGray
                self.addSubview(label!)
//                self.setValue(label!, forKey: "_placeholderLabel") // 听说iOS13 会崩溃
                addObserver() // 在此添加观察者 保证只添加一次
                objc_setAssociatedObject(self, UITextView.RuntimeKey.hw_placeholderLabelKey!, label!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.sendSubviewToBack(label!)
            }
            return label!
        }
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.hw_placeholderLabelKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 添加观察者监听内容改变
    private func addObserver() {
        #if swift(>=4.2)
        let UITextViewTextDidChange = UITextView.textDidChangeNotification
        #else
        let UITextViewTextDidChange = Notification.Name.UITextViewTextDidChange
        #endif
        NotificationCenter.default.addObserver(self, selector: #selector(refreshPlaceholder), name:UITextViewTextDidChange, object: self)
    }
    
    
    @objc internal func refreshPlaceholder() {
        if !text.isEmpty || !attributedText.string.isEmpty {
            placeholderLabel.alpha = 0
        } else {
            placeholderLabel.alpha = 1
        }
    }
  
    open override func removeFromSuperview() {
        super.removeFromSuperview()
        placeholderLabel.removeFromSuperview() // 移除占位Label
        NotificationCenter.default.removeObserver(self) // 移除观察者
    }
}

// MARK: - 调整文字内容在左上角
class UITextViewPlaceholderLabel: UILabel {
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.y = bounds.origin.y
        return textRect
    }
    override func drawText(in rect: CGRect) {
        let actualRect = textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: actualRect)
    }
}
