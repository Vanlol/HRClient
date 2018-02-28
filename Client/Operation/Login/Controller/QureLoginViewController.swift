//
//  QureLoginViewController.swift
//  Client
//
//  Created by Hengzhan on 2018/2/28.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit

class QureLoginViewController: BaseViewController {
    
    
    
    fileprivate let loginService = LoginService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
    }
    //MARK: 初始化导航栏
    fileprivate func initNav() {
        super.setUpBackButton()
        super.setUpNavTitle(title: "确认登录")
    }
}
