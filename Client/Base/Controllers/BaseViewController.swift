//
//  BaseViewController.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/4.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
    }
    /**
     * 设置标题
     */
    public func setUpNavTitle(title:String) {
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = UIColor.orange
    }
    /**
     * 设置返回按钮颜色，但是不会影响侧滑返回
     */
    public func setUpBackButton() {
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    /**
     * 显示导航栏
     */
    public func showNav() {
        navigationController?.isNavigationBarHidden = false
    }
    /**
     * 隐藏导航栏
     */
    public func hideNav() {
        navigationController?.isNavigationBarHidden = true
    }
    /**
     * 设置导航栏阴影
     */
    public func setUpNavShadow() {
        navigationController?.navigationBar.layer.shadowColor = 0x3C6CDE.HexColor.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
        navigationController?.navigationBar.layer.shadowOpacity = 0.3
        navigationController?.navigationBar.layer.shadowRadius = 4
    }
    /**
     * 设置导航栏标题,导航栏的标题是"系统的文字,有加粗.“
     */
    public func setUpSystemNav(title:String,hexColorBg:Int){
        navigationItem.title = title
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage.colorImage(hex: hexColorBg), for: .any, barMetrics: .default)
    }
    /**
     * 设置导航栏标题,文字颜色与大小等
     */
    public func setUpCustomNav(title:String,hexColorTitle:UIColor,hexColorBg:Int) {
        let titleLab = UILabel()
        titleLab.bounds = CGRect(x: 0, y: 0, width: 150, height: 20)
        titleLab.text = title
        titleLab.textAlignment = .center
        titleLab.textColor = hexColorTitle
        titleLab.font = UIFont.systemFont(ofSize: 17)
        navigationItem.titleView = titleLab
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage.colorImage(hex: hexColorBg), for: .any, barMetrics: .default)
    }
    
    public func tabPushVCWith(storyboardName:String,vcId:String){
        let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: vcId)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /** 退出账号登录 **/
    public func signOut(){
        U.setMobile(mobile: Str.No_Mobile)
        U.setUserId(Id: "")
        U.setCookie(cookie: "")
//        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
//        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: loginVC)
    }
    
    
    
    
}

extension BaseViewController {
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
    func parentViewController() -> UIViewController? {
        var nex:UIResponder?
        nex = next!
        repeat {
            //2.判断响应者对象是否是视图控制器类型
            if ((nex as?UIViewController) != nil) {
                return (nex as! UIViewController)
                
            }else {
                nex = nex?.next
            }
            
        } while next != nil
        
        return UIViewController()
    }
}









