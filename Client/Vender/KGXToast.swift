//
//  KGXToast.swift
//  KGXToastDemo
//
//  Created by keygx on 2015/01/12.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

// Toast表示時間
enum ToastDisplayDuration : Int {
    case LengthSuperShort
    case LengthShort
    case LengthNormal
    case LengthLong
    case LengthLongLong
    func getDurationTime() -> Double {
        switch self {
        case .LengthSuperShort:
            return 1
        case .LengthShort:
            return 2.5
        case .LengthNormal:
            return 4.0
        case .LengthLong:
            return 4.5
        case .LengthLongLong:
            return 5.0
        }
    }
}

private var baseWindow: UIWindow? = nil
private let windowWidthRatio: CGFloat = 0.9 // 90% of parent screen width
private let windowAlphaValue: CGFloat = 1
private let fontSize: CGFloat = 15.0

class KGXToast: UIWindow {
    
    class func showToastWithMessage(_ message: String, duration: ToastDisplayDuration) -> Void {
        
        //所有键盘回收
         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        // ステータスバーの向き(画面回転方向)
        let orientation:UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        
        // UIWindowの作成
        if baseWindow == nil {
            // baseWindowの設定
            switch orientation {
            case .landscapeLeft:
                fallthrough
            case .landscapeRight:
                // LandscapeLeft | LandscapeRight
                baseWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width))
            default:
                // Unknown | Portrait | PortraitUpsideDown
                //                println("default:::::\(UIScreen.mainScreen().bounds.size.height)")
                //                print("windows = \(UIApplication.sharedApplication().windows)")
                baseWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.height))
                //                baseWindow = UIApplication.sharedApplication().windows.last
            }
            baseWindow?.alpha = 0
            baseWindow?.isUserInteractionEnabled = false
            baseWindow?.windowLevel = UIWindowLevelNormal
        }
        
        // ToastViewのサイズ
        let toastViewRect:CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * windowWidthRatio, height: UIScreen.main.bounds.height)
        
        // 1行の文字数
        let oneLineLength = floor(toastViewRect.width * windowWidthRatio / fontSize)
        
        // Labelの幅
        let labelWidth = oneLineLength * fontSize
        // Labelを作成する
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: labelWidth, height: 10))
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.isUserInteractionEnabled = false
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: fontSize)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = NSTextAlignment.left
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        
        // Toastを作成
        let toastView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: messageLabel.bounds.width + 10 + 10, height: messageLabel.bounds.height + 10 + 10 + 1))
        toastView.backgroundColor = UIColor(red: 251/255, green: 111/255, blue: 62/255, alpha: 1)
        toastView.isUserInteractionEnabled = false
        toastView.layer.cornerRadius = 9
        toastView.layer.borderColor = UIColor(red: 251/255, green: 111/255, blue: 62/255, alpha: 1).cgColor
        toastView.layer.borderWidth = 1
        toastView.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        toastView.layer.shadowColor = UIColor.black.cgColor
        toastView.layer.shadowOpacity = 0.4
        
        toastView.addSubview(messageLabel)
        
        // Toast用Viewの回転
        /**
         * Viewは自動的に回転しないので、画面の向きにあわせる。
         */
        var angle:CGFloat
        switch (orientation) {
        case .portrait:
            // Portrait
            angle = CGFloat(0.0 * M_PI / 180.0)
        case .portraitUpsideDown:
            // PortraitUpsideDown
            angle = CGFloat(180.0 * M_PI / 180.0)
        case .landscapeLeft:
            // LandscapeLeft
            angle = CGFloat(-90.0 * M_PI / 180.0)
        case .landscapeRight:
            // LandscapeRight
            angle = CGFloat(90.0 * M_PI / 180.0)
        default:
            // Unknown
            angle = CGFloat(0.0 * M_PI / 180.0)
        }
        toastView.transform = CGAffineTransform(rotationAngle: angle)
        baseWindow?.addSubview(toastView)
        
        // センタリング
        toastView.center = CGPoint(x: baseWindow!.center.x, y: baseWindow!.bounds.height - toastView.bounds.height - 50)
        //toastView.center = CGPoint(x: baseWindow!.center.x, y: baseWindow!.center.y)
        
        // Toast表示
        self.show(duration: duration.getDurationTime())
    }
    
    private class func show(duration: Double) -> Void {
        // baseWindowをkeyWindowにする
        baseWindow?.makeKey()
        
        // baseWindowを表示する
        baseWindow?.makeKeyAndVisible()
        
        // フェードイン
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                baseWindow?.alpha = windowAlphaValue
                return
            },
            completion:nil /*{
             (value: Bool) in
             }*/
        )
        
        // Toast表示時間
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
            self.dismiss()
        })
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//            // your function here
//            self.dismiss()
//        }
    }
    
    class func shortDismiss() -> Void {
        baseWindow?.removeFromSuperview()
        baseWindow = nil
    }
    
    private class func dismiss() -> Void {
        // フェードアウト
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                baseWindow?.alpha = 0
                return
            },
            completion: {
                (value: Bool) in
                baseWindow?.removeFromSuperview()
                baseWindow = nil
            }
        )
    }
}
