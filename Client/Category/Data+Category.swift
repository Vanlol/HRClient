//
//  Data+Category.swift
//  ydzbapp-hybrid
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 银多资本. All rights reserved.
//

import Foundation

extension Data {
    //AES128 加密
    func AES128Cryptt(operation:CCOperation,keyData:Data) -> NSData {
        
        let keyBytes = (keyData as NSData).bytes
        let keyLength = Int(kCCKeySizeAES128)
        
        let dataLength = (self as NSData).length
        let dataBytes = (self as NSData).bytes
        
        let cryptLength = Int(dataLength + kCCBlockSizeAES128)
        let cryptPointer = UnsafeMutablePointer<UInt8>.allocate(capacity: cryptLength)
        
        let algoritm = CCAlgorithm(kCCAlgorithmAES128)
        let option = CCOptions(kCCOptionECBMode + kCCOptionPKCS7Padding)
        
        let numBytesEncrypted = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        numBytesEncrypted.initialize(to: 0)
        
        let cryptStatus = CCCrypt(operation, algoritm, option, keyBytes, keyLength, nil, dataBytes, dataLength, cryptPointer, cryptLength, numBytesEncrypted)
        
        if CCStatus(cryptStatus) == CCStatus(kCCSuccess) {
            Print.dlog("AES --- Success")
            let len = Int(numBytesEncrypted.pointee)
            let data = NSData(bytesNoCopy: cryptPointer, length: len)
            numBytesEncrypted.deallocate(capacity: 1)
            return data
        }else{
            Print.dlog("AES --- fail")
            numBytesEncrypted.deallocate(capacity: 1)
            cryptPointer.deallocate(capacity: cryptLength)
            return NSData()
        }
        
    }
    
}

