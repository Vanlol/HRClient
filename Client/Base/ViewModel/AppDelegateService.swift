//
//  AppDelegateService.swift
//  Doctor
//
//  Created by Hengzhan on 2017/12/28.
//  Copyright © 2017年 Hengzhan. All rights reserved.
//

import Foundation
import SignalR_ObjC

class AppDelegateService:NSObject {
    
    static let shared = AppDelegateService()
    static let config = Config()
    //MARK: 设置singalR
    public func setUpSingalR() {
        let hubConnection = SRHubConnection(urlString: AppDelegateService.config.netApi + "signalr")
        hubConnection?.addValue(U.getCookie()!, forHTTPHeaderField: "Cookie")
        hubConnection?.delegate = self
        let chat = hubConnection?.createHubProxy("messageHub")
        _ = chat?.on("addMessage", perform: self, selector: #selector(addMessage(message:)))
        
        hubConnection?.start()
    }
    
    @objc func addMessage(message:String) {
        
    }
    
}

//MARK : SRConnectionDelegate
extension AppDelegateService:SRConnectionDelegate {
    
    func srConnection(_ connection: SRConnectionInterface!, didReceiveData data: Any!) {
        //MessageType : 广播-全部,客服-对话,客服-系统-创建会话,系统-帐户-提交用户意见,系统-消息,健康-预约专家-回复,健康-预约专家-提醒,健康-健康建议
        let dict = data as! [String:Any]
        let A = dict["A"] as! [[String:Any]]
        if A.count > 0 {
            let Content = A.first!["Content"] as! [String:Any]
            let MessageType = Content["MessageType"] as! String
            let TextContent = Content["TextContent"] as! String
            Print.dlog(TextContent)
            Print.dlog(MessageType)
            if MessageType == "客服-对话" {        //客服回话
                KGXToast.showToastWithMessage("收到一条新的客服消息", duration: ToastDisplayDuration.LengthShort)
                NotificationCenter.default.post(name: Notification.Name(rawValue: Str.messageNotifi), object: false)
                let localNote = UILocalNotification()
                localNote.alertBody = TextContent
                UIApplication.shared.scheduleLocalNotification(localNote)
            }
        }
        
    }
    
}


extension AppDelegateService {
    //获取当前屏幕显示的控制器
    public func getCurrentVC() -> UIViewController {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindowLevelNormal {
                    window = tmpWin
                    break
                }
            }
        }
        let frontView = window?.subviews[0]
        let nextResponder = frontView?.next
        if (nextResponder?.isKind(of: UIViewController.classForCoder()))! {
            return nextResponder as! UIViewController
        }else{
            return (window?.rootViewController)!
        }
    }
    
    
    
}


