//
//  HanPublicBlock.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/10.
//  Copyright © 2019 Han. All rights reserved.
//
//
//  定义HanTools中所有用到的Block
//

import UIKit

/// 带图片的block
typealias HanImageBlock = (_ image:UIImage?) -> Void

/// 带error的block
typealias HanErrorBlock = (_ error: NSError?) -> Void
