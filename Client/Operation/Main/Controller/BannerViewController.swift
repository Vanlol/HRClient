//
//  BannerViewController.swift
//  Client
//
//  Created by Hengzhan on 2018/3/6.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit
import WebKit

class BannerViewController: BaseViewController {
    
    public var banner = BannerModel()
    
    fileprivate lazy var contentWebView:WKWebView = {
        let configuretion = WKWebViewConfiguration()
        configuretion.preferences = WKPreferences()
        configuretion.preferences.minimumFontSize = 10
        configuretion.preferences.javaScriptEnabled = true
        configuretion.preferences.javaScriptCanOpenWindowsAutomatically = false
        configuretion.userContentController = WKUserContentController()
        configuretion.userContentController.add(self, name: "CustomName")
        let rect = CGRect(x: 0, y: 0, width: Screen.Width, height: Screen.Height)
        let vi = WKWebView(frame: rect, configuration: configuretion)
        vi.navigationDelegate = self
        vi.scrollView.isScrollEnabled = false
        vi.scrollView.bounces = false
        vi.scrollView.showsVerticalScrollIndicator = false
        vi.scrollView.showsHorizontalScrollIndicator = false
        return vi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initView()
    }
    //MARK: 初始化导航栏
    fileprivate func initNav() {
        super.setUpBackButton()
        if banner.Profile == "" {
            super.setUpNavTitle(title: "无标题")
        }else{
            super.setUpNavTitle(title: banner.Profile)
        }
    }
    //MARK: 初始化视图
    fileprivate func initView(){
        let url = URL(string: banner.ContentUrl)
        if url != nil {
            contentWebView.load(URLRequest(url: url!))
        }
        view.addSubview(contentWebView)
    }
}

extension BannerViewController:WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "CustomName" {
            let dict = message.body as! [String:Any]
            Print.dlog(dict)
        }
    }
}


