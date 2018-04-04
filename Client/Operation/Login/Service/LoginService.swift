//
//  LoginService.swift
//  Doctor
//
//  Created by Hengzhan on 2017/12/19.
//  Copyright © 2017年 Hengzhan. All rights reserved.
//

import Foundation

class LoginService {
    static let config = Config()
    static let shared = LoginService()
    /** 获取微信的openID **/
    func getWeChatOpenId(code:String, closure:@escaping ((Any) -> Void)) {
        let urlStr = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + B.WEIXIN_ID + "&secret=" + B.WEIXIN_SECRECT + "&code=" + code + "&grant_type=authorization_code"
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { //开辟分线程
            let url = URL(string: urlStr)
            let zoneStr = try! String(contentsOf: url!, encoding: String.Encoding.utf8)
            let data = zoneStr.data(using: String.Encoding.utf8)!
            DispatchQueue.main.async(execute: { //回到主线程
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: data as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let jsonStr = String(data: jsonData, encoding: String.Encoding.utf8)
                    Print.dlog(jsonStr!)
                }catch{
                    Print.dlog(" 微信openID解析失败 \(error)")
                }
                
            })
        }
    }
    /** 登录 **/
    func loadLogin(param:[String:Any], closure:@escaping ((Any) -> Void)) {
        RestAPI.sendPostRequest(request: N.Login_Login, param: param, success: { (task, data) in
            let resp = (task.response! as! HTTPURLResponse).allHeaderFields as! [String:Any]
            let cookie = resp["Set-Cookie"] as! String
            U.setCookie(cookie: cookie)
            closure(data!)
        }) { (error) in
            Print.dlog("error --- \(error!)")
        }
    }
    /** 验证码 **/
    func loadAuthcode(param:[String:Any], closure:@escaping ((Any) -> Void)) {
        RestAPI.sendPostRequest(request: N.Login_SendMobileVerifyCode, param: param, success: { (task, data) in
            closure(data!)
        }) { (error) in
            Print.dlog("error --- \(error!)")
        }
    }
    /** 注册 **/
    func loadRegister(param:[String:Any], closure:@escaping ((Any) -> Void)) {
        RestAPI.sendPostRequest(request: N.Login_Register, param: param, success: { (task, data) in
            closure(data!)
        }) { (error) in
            Print.dlog("error --- \(error!)")
        }
    }
    /** 忘记密码 **/
    func loadResetPassword(param:[String:Any], closure:@escaping ((Any) -> Void)) {
        RestAPI.sendPostRequest(request: N.Login_ResetPassword, param: param, success: { (task, data) in
            closure(data!)
        }) { (error) in
            Print.dlog("error --- \(error!)")
        }
    }
}

