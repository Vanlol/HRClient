//
//  UIImage+Category.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/5.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
     * 用颜色生产一张image
     */
    public class func colorImage(hex:Int) -> UIImage {
        let size = CGSize(width: UIScreen.main.bounds.size.width, height: 64)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        hex.HexColor.set()
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        path.fill()
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return colorImage
    }
    
}

