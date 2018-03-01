//
//  U.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 admin. All rights reserved.
//

import Foundation

/**-------------新项目需要---------------**/
let suiteName = "com.yinduoziben.app"     //需要换成项目地址
let KeyNetType = "netWorkType"            //网络环境类型
let KeyMobile = "mobile"                  //手机号 NWNDMkkvVEVDK1ZCell2UTZiSk5Tdz09
let KeyHistory = "history"                //手机号 NWNDMkkvVEVDK1ZCell2UTZiSk5Tdz09
let KeyCookie = "Cookie"                  //Cookie
let KeyUserId = "userId"                  //医生的UserId
let KeyVersion = "version"                //版本号



let userDefault = UserDefaults(suiteName: suiteName)!

//本地化存储
class U: NSObject {
    /** 医生UserId **/
    class func getVersion() -> String? {
        if let version = userDefault.object(forKey: KeyVersion) as? String {
            return version
        }else{
            return "1.0.0"
        }
    }
    class func setVersion(version:String) {
        userDefault.set(version, forKey: KeyVersion)
        userDefault.synchronize()
    }
    class func getUserId() -> String? {
        if let Id = userDefault.object(forKey: KeyUserId) as? String {
            return Id
        }else{
            return ""
        }
    }
    class func setUserId(Id:String) {
        userDefault.set(Id, forKey: KeyUserId)
        userDefault.synchronize()
    }
    
    /** Cookie **/
    class func getCookie() -> String? {
        if let cookie = userDefault.object(forKey: KeyCookie) as? String {
            return cookie
        }else{
            return ""
        }
    }
    class func setCookie(cookie:String) {
        userDefault.set(cookie, forKey: KeyCookie)
        userDefault.synchronize()
    }
    //MARK: 获取手机号
    class func getMobile() -> String? {
        if let al = userDefault.object(forKey: KeyMobile) as? String {
            return al
        }else{
            return Str.No_Mobile
        }
    }
    //MARK: 设置手机号
    class func setMobile(mobile:String) {
        userDefault.set(mobile, forKey: KeyMobile)
        userDefault.synchronize()
    }
    //MARK: 获取手机号
    class func getHistory() -> [String]? {
        if let al = userDefault.object(forKey: KeyHistory) as? [String] {
            return al
        }else{
            return [""]
        }
    }
    //MARK: 设置手机号
    class func setHistory(historys:[String]) {
        userDefault.set(historys, forKey: KeyHistory)
        userDefault.synchronize()
    }
    //MARK: 获取网络状态环境
    class func getNetWorkType() -> String? {
        if let type = userDefault.object(forKey:  KeyNetType) as? String {
            return type
        }else{
            return ""
        }
    }
    //MARK: 设置网络状态环境
    class func setNetWorkType(newtWorkType:String) {
         userDefault.set(newtWorkType, forKey: KeyNetType)
    }
    
    
}

