//
//  Int+Category.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

extension Int {
    
    /**
     * 生成十六进制颜色
     */
    public var HexColor : UIColor {
        guard self > 0 else {
            return UIColor.white
        }
        let red = (CGFloat)((self & 0xFF0000) >> 16) / 255.0
        let green = (CGFloat)((self & 0xFF00) >> 8) / 255.0
        let blue = (CGFloat)((self & 0xFF)) / 255.0
        if #available(iOS 10, *) {
            return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1.0)
        }
        guard #available(iOS 10, *) else {
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        return UIColor.black
    }
    
}

