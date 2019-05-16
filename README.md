# HanSwiftTools
Swift工具类  
HanSwiftTools相关说明  

系统版本     10.14.4  
Xcode版本   10.1  
Swift版本   4.2  

Extension文件夹  
为扩展系统方法文件夹  
定义格式(命名规则)：HanTools_xxx.swift  

例:HanTools_View.swift  
为扩展UIVIew的文件，里面扩展了UIView的一些方法  


CustomSystemControls文件夹  
为自定义系统控件的文件夹  
定义格式(命名规则)：Hanxxx.swift  

例:HanImagePicker.swift  
为扩展系统UIImagePickerController的文件，里面封装了UIImagePickerController  


BasicDefine文件夹  
为一些基础定义文件夹  
1.HanBasicDefine.swift   
主要是获取系统的一些属性以及iPhone机型的判断，另外添加了以 4.7英寸（375 * 667）为基础缩比例scaleHeight和scaleWidth方法。  

2.HanPublicBlock  
定义HanTools所有用到的Block类型  
定义格式(命名规则)：HanxxxBlock  

例:HanImageBlock  
为带UIImage的Block  


HanCustomView文件夹  
我自己封装的一些控件  
