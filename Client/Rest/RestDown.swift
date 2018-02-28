//
//  RestDown.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/7.
//  Copyright © 2017年 admin. All rights reserved.
//

import Foundation
import AFNetworking

class RestDown : AFURLSessionManager {
    
    static let shared = RestDown()
    class var sharedInstance:RestDown {
        return shared
    }
    
}



