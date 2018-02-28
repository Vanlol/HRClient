//
//  RegistViewController.swift
//  Doctor
//
//  Created by Hengzhan on 2017/12/18.
//  Copyright © 2017年 Hengzhan. All rights reserved.
//

import UIKit

class RegistViewController: BaseViewController {
    
    @IBOutlet weak var headerVi: UIView!{
        didSet{
            headerVi.layer.cornerRadius = 35
        }
    }
    @IBOutlet weak var authcodeBtn: UIButton!{
        didSet{
            authcodeBtn.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var loginBtn: UIButton!{
        didSet{
            loginBtn.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var mobileTF: UITextField! //账号
    @IBOutlet weak var authcodeTF: UITextField! //短信验证码
    @IBOutlet weak var pswdTF: UITextField!   //密码
    fileprivate let loginService = LoginService.shared
    fileprivate var count = 89
    public var openId = ""
    public var authType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
    }
    //MARK: 初始化导航栏
    fileprivate func initNav() {
        super.setUpBackButton()
        if authType == "" {
            super.setUpNavTitle(title: "注册")
        }else{
            super.setUpNavTitle(title: "完善信息")
        }
    }
    //MARK: 获取验证码点击事件
    @IBAction func authcodeButtonClick(_ sender: UIButton) {
        if mobileTF.text?.count == 0 {
            KGXToast.showToastWithMessage("请输入手机号", duration: ToastDisplayDuration.LengthShort)
            return
        }
        if mobileTF.text?.count != 11 {
            KGXToast.showToastWithMessage("手机号格式不正确", duration: ToastDisplayDuration.LengthShort)
            return
        }
        loginService.loadAuthcode(param: ["MobileNumber":mobileTF.text!]) { (data) in
            self.authCodeButtonCountDown()
        }
    }
    //MARK: 登录并注册点击事件
    @IBAction func loginAndRegistButtonClick(_ sender: UIButton) {
        if mobileTF.text?.count == 0 {
            KGXToast.showToastWithMessage("请输入手机号", duration: ToastDisplayDuration.LengthShort)
            return
        }
        if mobileTF.text?.count != 11 {
            KGXToast.showToastWithMessage("手机号格式不正确", duration: ToastDisplayDuration.LengthShort)
            return
        }
        if authcodeTF.text?.count == 0 {
            KGXToast.showToastWithMessage("请输入验证码", duration: ToastDisplayDuration.LengthShort)
            return
        }
        if pswdTF.text?.count == 0 {
            KGXToast.showToastWithMessage("请输入登录密码", duration: ToastDisplayDuration.LengthShort)
            return
        }
        loginService.loadRegister(param: ["MobileNumber":mobileTF.text!,"MobileVerifyCode":authcodeTF.text!,"Password":pswdTF.text!,"Openid":openId,"AuthType":authType]) {(data) in
            self.gotoLogin()
        }
    }
    
    fileprivate func gotoLogin() {
        loginService.loadLogin(param:["MobileNumber":mobileTF.text!,"Password":pswdTF.text!], closure: {(data) in
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewControllerID") as! MainViewController
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: mainVC)
        })
    }
    //MARK: 协议按钮点击事件
    @IBAction func agreementButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    //MARK: 用户协议点击事件
    @IBAction func dealButtonClick(_ sender: Any) {
        
    }
    
    //MARK: - 验证码倒计时
    fileprivate func authCodeButtonCountDown() {
        authcodeBtn.alpha = 0.5
        authcodeBtn.setTitle("\(count)s重新发送", for: .normal)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown(timer:)), userInfo: authcodeBtn, repeats: true)
    }
    @objc func countDown(timer:Timer) {
        let button = timer.userInfo as! UIButton
        button.isEnabled = false
        count -= 1
        button.setTitle("\(count)s重新发送", for: .normal)
        if count < 0 {
            button.setTitle("重新发送", for: .normal)
            button.alpha = 1
            button.isEnabled = true
            timer.invalidate()
            count = 89
        }
    }
    
    
}
