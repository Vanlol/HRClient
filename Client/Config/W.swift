//
//  W.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 admin. All rights reserved.
//

import Foundation
//web 外网接口地址
struct W {
    
    static let env = Config().webUrl
    
    /** 存管没完全开通页 有的步骤没走 **/
    static let CUSTODY_APP_JUMP = env + "index.php/App/Custody/appJump/mm/"
    
    
}
