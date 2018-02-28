//
//  PersonTableViewController.swift
//  Client
//
//  Created by Hengzhan on 2018/2/7.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit

class PersonTableViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
    }
    //MARK: 初始化导航栏
    fileprivate func initNav() {
        super.setUpBackButton()
        super.setUpNavTitle(title: "个人中心")
        navigationItem.rightBarButtonItem = UIBarButtonItem.rightItemWithTitle(title: "退出账号", color: 0xFB6F3E, target: self, action: #selector(signOutButtonClick))
    }
    //MARK: 退出账号按钮点击事件
    @objc func signOutButtonClick() {
        super.signOut()
    }
}
