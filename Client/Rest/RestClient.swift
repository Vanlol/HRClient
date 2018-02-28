//
//  RestClient.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/7.
//  Copyright © 2017年 admin. All rights reserved.
//

import Foundation
import AFNetworking

class RestClient : AFHTTPSessionManager {
    
    static let shared = RestClient()
    
    class var sharedInstance:RestClient {
        //设置超时时间30秒
        shared.responseSerializer = AFHTTPResponseSerializer()
        shared.requestSerializer = AFHTTPRequestSerializer()
        shared.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        shared.requestSerializer.timeoutInterval = 30
        shared.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        shared.requestSerializer.setValue(U.getCookie(), forHTTPHeaderField: "Cookie")
        return shared
    }
    
    //MARK: 检测网络环境
    func checkNetWork() {
        let manager = AFNetworkReachabilityManager.shared()
        manager.startMonitoring()  //提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
        manager.setReachabilityStatusChange { (status) in
            switch status {
            case .unknown:
                Print.dlog("未识别网络")
                U.setNetWorkType(newtWorkType: "unknown")
            case .notReachable:
                Print.dlog("未连接网络")
                U.setNetWorkType(newtWorkType: "nonetwrok")
            case .reachableViaWWAN:
                Print.dlog("3g/4g 网络")
                U.setNetWorkType(newtWorkType: "3g/4g")
            case .reachableViaWiFi:
                Print.dlog("wifi 网络")
                U.setNetWorkType(newtWorkType: "wifi")
            }
        }
    }
    
}

