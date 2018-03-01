//
//  LoginViewController.swift
//  Client
//
//  Created by Hengzhan on 2018/2/6.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var headerVi: UIView!{
        didSet{
            headerVi.layer.cornerRadius = 35
        }
    }
    @IBOutlet weak var loginBtn: UIButton!{
        didSet{
            loginBtn.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var registBtn: UIButton!{
        didSet{
            registBtn.layer.cornerRadius = 5
            registBtn.layer.borderWidth = 1
            registBtn.layer.borderColor = 0xFB6F3E.HexColor.cgColor
        }
    }
    @IBOutlet weak var mobileTF: UITextField! //账号
    @IBOutlet weak var pswdTF: UITextField!   //密码
    fileprivate let loginService = LoginService.shared
    
    fileprivate var tencentOAuth:TencentOAuth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initNotifi()
    }
    //MARK: 初始化导航栏
    fileprivate func initNav() {
        super.setUpBackButton()
        tencentOAuth = TencentOAuth(appId: B.QQ_ID, andDelegate: self)
    }
    //MARK: 注册通知
    fileprivate func initNotifi() {
        NotificationCenter.default.addObserver(self, selector: #selector(thirdLoginNotifi(notifi:)), name: Notification.Name(rawValue: Str.ThirdLoginNotifi), object: nil)
    }
    //MARK: 注销方法
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Str.ThirdLoginNotifi), object: nil)
    }
    //MARK: 第三方登录通知
    @objc func thirdLoginNotifi(notifi:Notification) {
        let code = notifi.userInfo!["code"] as! String
        Print.dlog(code)
    }
    //MARK: 忘记密码点击事件
    @IBAction func forgotPasswdButtonClick(_ sender: Any) {
        let forgotVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ForgotPswdViewControllerID") as! ForgotPswdViewController
        navigationController?.pushViewController(forgotVC, animated: true)
    }
    //MARK: 登录点击事件
    @IBAction func loginButtonClick(_ sender: Any) {
        if mobileTF.text?.count == 0 {
            KGXToast.showToastWithMessage("请输入账号", duration: ToastDisplayDuration.LengthShort)
            return
        }
        if pswdTF.text?.count == 0 {
            KGXToast.showToastWithMessage("请输入密码", duration: ToastDisplayDuration.LengthShort)
            return
        }
        if mobileTF.text?.count != 11 {
            KGXToast.showToastWithMessage("手机号格式不正确", duration: ToastDisplayDuration.LengthShort)
            return
        }
        loginService.loadLogin(param: ["MobileNumber":mobileTF.text!,"Password":pswdTF.text!]) {(data) in
            U.setMobile(mobile: self.mobileTF.text!)
            let tabVC = UIStoryboard(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewControllerID") as! TabbarViewController
            UIApplication.shared.keyWindow?.rootViewController = tabVC
        }
    }
    //MARK: 快速注册点击事件
    @IBAction func registerButtonClick(_ sender: Any) {
        let registVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "RegistViewControllerID") as! RegistViewController
        navigationController?.pushViewController(registVC, animated: true)
    }
    
    //MARK: 微信登录点击事件
    @IBAction func weiChatButtonClick(_ sender: Any) {
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        WXApi.send(req)
    }
    //MARK: qq登录点击事件
    @IBAction func QQButtonClick(_ sender: Any) {
        tencentOAuth.authorize(["get_user_info", "get_simple_userinfo", "add_t"], inSafari: false)
    }
    
}
//MARK: QQ登录回调代理
extension LoginViewController:TencentSessionDelegate {
    func tencentDidLogin() {
        Print.dlog("tencentDidLogin  --- \(tencentOAuth.openId)")
    }
    
    func tencentDidNotLogin(_ cancelled: Bool) {
        Print.dlog("tencentDidNotLogin")
    }
    
    func tencentDidNotNetWork() {
        Print.dlog("tencentDidNotNetWork")
    }
}




