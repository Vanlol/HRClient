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

