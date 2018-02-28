//
//  BaseWKWebViewController.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/21.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit
import WebKit

class BaseWKWebViewController: BaseViewController {
    
    public var userContent:WKUserContentController!
    
    public lazy var webView:WKWebView = {
        let config = WKWebViewConfiguration()
        let userCon = WKUserContentController()
        config.userContentController = userCon
        self.userContent = userCon
        let vi = WKWebView(frame: CGRect.zero, configuration: config)
        vi.translatesAutoresizingMaskIntoConstraints = false
        vi.navigationDelegate = self
        vi.scrollView.contentInset = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        vi.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        return vi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initWebView()
    }
    /**
     * 初始化webView
     */
    fileprivate func initWebView() {
        view.addSubview(webView)
        let leading = NSLayoutConstraint(item: webView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: webView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 64.0)
        let bottom = NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        view.addConstraints([leading,trailing,top,bottom])
    }
    
}

extension BaseWKWebViewController:WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        Print.dlog(error)
//        Print.dlog("webView --- didFail")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        Print.dlog(error)
//        Print.dlog("webView --- didFailProvisionalNavigation")
    }
    
}



