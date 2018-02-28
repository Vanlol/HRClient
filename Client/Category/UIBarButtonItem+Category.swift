//
//  UIBarButtonItem+Category.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/5.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /**
     * 快速创建返回按钮
     */
    public class func rightItemWithTitle(title:String,color:Int,target:Any,action:Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(color.HexColor, for: .normal)
        btn.bounds.size = CGSize(width: 70, height: 35)
        btn.contentHorizontalAlignment = .right
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    
    /**
     * 快速创建返回按钮
     */
    public class func backItemWithImage(image:String,target:Any,action:Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named:image), for: .normal)
        btn.bounds.size = CGSize(width: 60, height: 35)
        btn.contentHorizontalAlignment = .left
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    /**
     * 快速创建只有图标的item
     */
    public class func itemWithImage(image:String,target:Any,action:Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named:image), for: .normal)
        btn.bounds.size = (btn.currentImage?.size)!
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    /**
     * 快速创建item,这个item只有图标
     */
    public class func itemWithImage(image:String,highImage:String,target:Any,action:Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named:image), for: .normal)
        btn.setBackgroundImage(UIImage(named:highImage), for: .highlighted)
        btn.bounds.size = (btn.currentBackgroundImage?.size)!
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    /**
     * 快速创建item,这个item有图标和文字
     */
    public class func itemWithTitleImage(title:String,image:String,highImage:String,target:Any,action:Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setImage(UIImage(named:image), for: .normal)
        btn.setImage(UIImage(named:highImage), for: .highlighted)
        btn.bounds.size = CGSize(width: 70, height: 35)
        btn.contentHorizontalAlignment = .left
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    
}
