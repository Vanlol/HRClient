//
//  MallViewController.swift
//  Client
//
//  Created by Hengzhan on 2018/2/7.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit

class MallViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
    }
    //MARK: 初始化导航栏
    fileprivate func initNav() {
        super.setUpBackButton()
        super.setUpNavTitle(title: "健康商城")
    }
}
