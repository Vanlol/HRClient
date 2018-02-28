//
//  SetTableViewController.swift
//  Client
//
//  Created by Hengzhan on 2018/2/7.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit

class SetTableViewController: BaseTableViewController {
    
    @IBOutlet weak var versionLab: UILabel!
    @IBOutlet weak var pointVi: UIView!{
        didSet{
            pointVi.layer.cornerRadius = 3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initView()
    }
    //MARK: 初始化导航栏
    fileprivate func initNav() {
        super.setUpBackButton()
        super.setUpNavTitle(title: "系统设置")
    }
    
    fileprivate func initView(){
        versionLab.text = U.getVersion()!
    }
    
}
