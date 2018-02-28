//
//  ForgotPswdViewController.swift
//  Doctor
//
//  Created by Hengzhan on 2017/12/18.
//  Copyright © 2017年 Hengzhan. All rights reserved.
//

import UIKit

class ForgotPswdViewController: BaseViewController {
    
    @IBOutlet weak var authcodeBtn: UIButton!{
        didSet{
            authcodeBtn.layer.cornerRadius = 4
        }
    }    //获取验证码
    
    @IBOutlet weak var qureBtn: UIButton!{
        didSet{
            qureBtn.layer.cornerRadius = 5
        }
    }          //确认按钮
    
    @IBOutlet weak var mobileTF: UITextField!    //注册手机号
    
    @IBOutlet weak var authcodeTF: UITextField!  //短信验证码
    
    @IBOutlet weak var newPswdTF: UITextField!   //新密码
    
    @IBOutlet weak var qurePswdTF: UITextField!  //确认密码
    
    var count = 89
    fileprivate let loginService = LoginService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
    }
    //MARK: 初始化导航栏
    fileprivate func initNav() {
        super.setUpBackButton()
        super.setUpNavTitle(title: "找回密码")
    }
    //MARK: 获取验证码按钮点击事件
    @IBAction func authCodeButtonClick(_ sender: UIButton) {
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
    //MARK: 确认按钮点击事件
    @IBAction func qureButtonClick(_ sender: UIButton) {
        
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
        if newPswdTF.text?.count == 0 {
            KGXToast.showToastWithMessage("请输入新密码", duration: ToastDisplayDuration.LengthShort)
            return
        }
        if qurePswdTF.text?.count == 0 {
            KGXToast.showToastWithMessage("请输入确认密码", duration: ToastDisplayDuration.LengthShort)
            return
        }
        if qurePswdTF.text != newPswdTF.text {
            KGXToast.showToastWithMessage("新密码与确认密码不同", duration: ToastDisplayDuration.LengthShort)
            return
        }
        
        loginService.loadResetPassword(param: ["MobileNumber":mobileTF.text!,"MobileVerifyCode":authcodeTF.text!,"Password":newPswdTF.text!], closure:{(data) -> Void in
            KGXToast.showToastWithMessage("修改成功,请登录", duration: ToastDisplayDuration.LengthShort)
            self.navigationController?.popViewController(animated: true)
        })
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
