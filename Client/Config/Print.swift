//
//  Print.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 admin. All rights reserved.
//

import Foundation

//自定义输出
class Print {
    
    static let config = Config()
    
    class func dlog(_ obj:Any) {
        if config.env != .production {
            print(obj)
        }
    }
    
}
