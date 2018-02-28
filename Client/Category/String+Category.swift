//
//  String+Category.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/25.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    //获得string内容高度
    func stringHeightWith(fontSize:CGFloat, width:CGFloat) -> CGFloat {
        
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [NSAttributedStringKey.font:font, NSAttributedStringKey.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
        
    }
    //获得string内容宽度
    func stringWidthWith(fontSize:CGFloat, height:CGFloat) -> CGFloat {
        
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [NSAttributedStringKey.font:font, NSAttributedStringKey.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.width
        
    }
//    let charSet = CharacterSet(charactersIn: "{}").inverted
//    let newJson = jsonstr!.addingPercentEncoding(withAllowedCharacters: charSet)
    //getitemurl:getItemUrl?id=2833&cname=%25u7528%25u6237%25u4EA4%25u6D41&comment=  webView返回的secume.
    //%25u7528%25u6237%25u4EA4%25u6D41解码
    //unescape解码,
    func unescape() -> String {
        let a = replacingOccurrences(of: "%u", with: "\\u")
        let transform:NSString = "Any-Hex/Java"
        let convertedString = a.mutableCopy() as! NSMutableString
        CFStringTransform(convertedString, nil, transform , true)
        var tmp = ""
        var indexS = 0
        let srcMain = convertedString as String
        while (indexS < srcMain.characters.count){
            let indexR = srcMain.index(srcMain.startIndex, offsetBy: indexS)
            if (srcMain[indexR] == "%" ){
                let indR1 = srcMain.index(indexR, offsetBy: 1)
                if (srcMain[indR1]=="u"){
                    let s1 = srcMain.index(indR1, offsetBy: 1)
                    let e1 = srcMain.index(indR1, offsetBy: 5)
                    let hex = srcMain[s1..<e1]
//                    let value = UInt32(strtoul(hex, nil, 16))
                    let value = ""
                    let dao:String = String(describing: UnicodeScalar(value)!)
                    tmp += dao
                    indexS += 6
                }else{
                    let s1 = srcMain.index(indR1, offsetBy: 0)
                    let e1 = srcMain.index(indR1, offsetBy: 2)
                    let hex = srcMain[s1..<e1]
//                    let value = UInt32(strtoul(hex, nil, 16))
                    let value = ""
                    let dao:String = String(describing: UnicodeScalar(value)!)
                    tmp += dao
                    indexS += 3
                }
            }else{
                tmp += String(srcMain[indexR])
                indexS+=1
            }
        }
        return tmp
    }
    //getitemurl:getItemUrl?id=2833&cname=%25u7528%25u6237%25u4EA4%25u6D41&comment=
    /*
     *拆分参数数据，上传购买数据
     *返回(类型，外网地址，产品名称)
     */
    func splitParameter() -> (String, String, String, String, String, String, String, String, String, String, String, String, String){
        var parm = (title: "", thumburl: "", gotourl: "", description: "", addr: "",arrow: "",numbers: "", msg:"", share:"", help:"", rightText:"", id:"", url:"")
        _ = range(of: "?")
        let result = components(separatedBy: "?").last
        let arr = result?.components(separatedBy: "&")
        for str in arr! {
            let ss = str.components(separatedBy: "=")
            if ss.first! == "title" {
                parm.title = ss.last!
            }else if ss.first! == "thumburl" {
                parm.thumburl = ss.last!
            }else if ss.first! == "gotourl" {
                parm.gotourl = ss.last!
            }else if ss.first! == "description" {
                parm.description = ss.last!
            }else if ss.first! == "addr" {
                parm.addr = ss.last!
            }else if ss.first! == "arrow" {
                parm.arrow = ss.last!
            }else if ss.first! == "numbers" {
                parm.numbers = ss.last!
            }else if ss.first! == "msg" {
                parm.msg = ss.last!
            }else if ss.first! == "share" {
                parm.share = ss.last!
            }else if ss.first! == "help" {
                parm.help = ss.last!
            }else if ss.first! == "cname" {
                parm.rightText = ss.last!
            }else if ss.first! == "id" {
                parm.id = ss.last!
            }else if ss.first! == "comment" {
                parm.url = ss.last!
            }
        }
        return parm
    }
    
    
    
    /*
     加密过程: 手机号 + "KEY"  ----(AES加密)---->   获得Data   ----加密结构Base64转码---->    获得试用的密钥
     */
    //MARK: AES128加密.
    func AES128Crypt() -> String {
        let key = "yinduozibenjiami"
        let ketData = (key as NSString).data(using: String.Encoding.utf8.rawValue)
        
        let mobileData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        
        let result = mobileData?.AES128Cryptt(operation: CCOperation(kCCEncrypt), keyData: ketData!)
        if result!.length > 0 {
            let str = result!.base64EncodedString(options: .lineLength64Characters)
            return str
        }else{
            Print.dlog("加密出错了!!!")
            return self
        }
    }
    
    /*
     * 数字的格式化:   eg: "1234567789.980988" -> "￥1,234,567,789.98"
     */
    func formatNumberStringRMBStyle() -> String {
        var newString = ""
        let numformat = NumberFormatter()
        numformat.numberStyle = .none
        let tmpNum = numformat.number(from: self)
        numformat.numberStyle = .currency
        if let tmpStr = numformat.string(from: tmpNum!) {
            newString = tmpStr
        }
        return newString
    }
    /*
     * 数字的格式化:   eg: "2666.901223" -> "2,666.901"
     */
    func formatNumberStringNoneStyle() -> String {
        var newString = ""
        let numformat = NumberFormatter()
        numformat.numberStyle = .decimal
        let tmpNum = numformat.number(from: self)
        if let tmpStr = numformat.string(from: tmpNum!) {
            newString = tmpStr
        }
        return newString
    }
    /*
     * 时间格式转换，  "2017-11-29T10:36:13.097+08:00" -> "2017-11-29" "yyyy-MM-dd'T'HH:mm:ss.SSS zz:z"
     */
    func formatterDateStringNormalStyle() -> String {
        var newStr = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = "yyyy-MM-d"
        if date != nil {
            newStr = dateFormatter.string(from: date!)
        }
        return newStr
    }
    /**
     * "2017-01-01"  -> 2017
     */
    func dateStrGetYear() -> Int {
        var year = 0
        let deRange = self.range(of: "-")
        if deRange != nil {
            let a = self.prefix(upTo: deRange!.lowerBound)
            year = Int(a)!
        }
        return year
    }
    
    func changeDateFormater() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        let date = dateformat.date(from: self)
        dateformat.dateFormat = "MM月dd"
        let str = dateformat.string(from: date!)
        return str
    }
    
    /** 将服务器返回的字符串时间取时,分,秒 **/
    func getSMH() -> String {
        let dateStr = "没有时间格式"
        if self == "" {
            return dateStr
        }else{
            let newStr = self.components(separatedBy: ".").first
            if newStr == nil {
                return dateStr
            }else{
                let resultStr = newStr?.components(separatedBy: "T").last
                if resultStr == nil {
                    return dateStr
                }else{
                    return resultStr!
                }
            }
        }
    }
    /** 将服务器返回的字符串时间取年,月,日 **/
    func getYMD() -> String {
        let dateStr = "没有时间格式"
        if self == "" {
            return dateStr
        }else{
            let newStr = self.components(separatedBy: ".").first
            if newStr == nil {
                return dateStr
            }else{
                let resultStr = newStr?.components(separatedBy: "T").first
                if resultStr == nil {
                    return dateStr
                }else{
                    return resultStr!
                }
            }
        }
    }
    /** 将服务器返回的字符串时间转时间 **/
    func formatterDate() -> Date {
        let newStr = self.replacingOccurrences(of: "+", with: " ")
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS zz:z"
        let date = fmt.date(from: newStr)
        if date != nil {
            return date!
        }else{
            return Date().currentZoneDate()
        }
    }
    
}
