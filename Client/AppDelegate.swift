//
//  AppDelegate.swift
//  Client
//
//  Created by Hengzhan on 2018/2/2.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        registerWeChat()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().toolbarTintColor = 0x5a5e6d.HexColor
        initWidows()
        return true
    }
    
    //MARK: wexin1, 注册微信id
    func registerWeChat() {
        WXApi.registerApp(B.WEIXIN_ID)
    }
    //MARK: weixin2,
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if url.host! == "safepay" {//阿里支付
            
        }else{
            return WXApi.handleOpen(url, delegate: self as WXApiDelegate) || TencentOAuth.handleOpen(url)
        }
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.host! == "safepay" {//阿里支付
            
        }else{
            return WXApi.handleOpen(url, delegate: self as WXApiDelegate) || TencentOAuth.handleOpen(url)
        }
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.host! == "safepay" {//阿里支付
            
        }else{
            return WXApi.handleOpen(url, delegate: self as WXApiDelegate) || TencentOAuth.handleOpen(url)
        }
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    //MARK: 初始化window
    fileprivate func initWidows() {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: Screen.Width, height: Screen.Height))
        window?.backgroundColor = 0xffffff.HexColor
        
        let infoDic = (Bundle.main.infoDictionary)!
        let currentVersion = infoDic["CFBundleShortVersionString"] as! String
        let lastVersion = U.getVersion()!
        if currentVersion != lastVersion { //加载引导页
            let guideVC = UIStoryboard(name: "Guide", bundle: nil).instantiateViewController(withIdentifier: "GuideViewControllerID") as! GuideViewController
            window?.rootViewController = guideVC
        }else{
            if U.getMobile() == Str.No_Mobile {
                let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
                window?.rootViewController = UINavigationController(rootViewController: loginVC)
            }else{
                let tabVC = UIStoryboard(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewControllerID") as! TabbarViewController
                window?.rootViewController = tabVC
            }
        }
        window?.makeKeyAndVisible()
        U.setVersion(version: currentVersion)
    }
}

extension AppDelegate:WXApiDelegate {
    func onReq(_ req: BaseReq!) {
        
    }
    func onResp(_ resp: BaseResp!) {
        if resp.isKind(of: SendAuthResp.classForCoder()) {
            let aresp = resp as! SendAuthResp
            if aresp.errCode == 0 {
                NotificationCenter.default.post(name: Notification.Name(rawValue: Str.ThirdLoginNotifi), object: self, userInfo: ["code":aresp.code])
            }
        }
    }
}




