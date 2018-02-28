//
//  Config.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/3.
//  Copyright © 2017年 admin. All rights reserved.
//

import Foundation
/*
 运行环境
 dev本地开发，webTest外网测试，production生产,productionText 218生产测试 ,kengFive 银多5.0 ,UATfive  uat测试接口
 */
enum Env {
    case dev,  production, whyDev ,wxwDev
}

struct Config {
    /***** 切换环境修改这里 开始 ******/
    let env = Env.dev
    /***** 切换环境修改这里 结束 ******/
    var phpApi = ""             //php接口地址
    var javaApi = ""            //java接口地址
    var netApi = ""             //.net接口地址
    var webUrl = ""             //web页面地址
    
    
    init() {
        switch env {
        //X.S.T
        case .dev:
            netApi = "http://192.168.1.104:9003/"
            phpApi = ""
            javaApi = ""
            webUrl = ""
        //W.H.Y
        case .whyDev:
            netApi = "http://192.168.1.102:9003/"
            phpApi = ""
            javaApi = ""
            webUrl = ""
        //W.X.W
        case .wxwDev:
            netApi = "http://192.168.1.113:9003/"
            phpApi = ""
            javaApi = ""
            webUrl = ""
        //生产环境
        case .production:
            netApi = ""
            phpApi = ""
            javaApi = ""
            webUrl = ""
        }
    }
    
    
}
