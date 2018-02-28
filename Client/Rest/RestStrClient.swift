//
//  RestStrClient.swift
//  Client
//
//  Created by Hengzhan on 2018/2/7.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import Foundation
import AFNetworking

class RestStrClient : AFHTTPSessionManager {
    
    static let shared = RestStrClient()
    
    class var sharedInstance:RestStrClient{
        shared.responseSerializer = AFHTTPResponseSerializer()
        shared.requestSerializer = AFHTTPRequestSerializer()
        shared.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        shared.requestSerializer.timeoutInterval = 30
        shared.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        shared.requestSerializer.setValue(U.getCookie(), forHTTPHeaderField: "Cookie")
        //shared.responseSerializer.acceptableContentTypes = NSSet(objects: "text/plain","text/json","application/json","text/javascript","text/html","application/javascript","text/js") as? Set<String>
        return shared
    }
    
}
