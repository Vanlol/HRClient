//
//  RestAPI.swift
//  SwiftCocoa
//
//  Created by admin on 2017/7/7.
//  Copyright © 2017年 admin. All rights reserved.
//

import Foundation

typealias Successed = ((URLSessionDataTask,Any?) -> Void)
typealias Failured = ((Error?) -> Void)

class RestAPI {
    
    static let config = Config()
    //.net GET 请求
    class func sendGetRequest(request: String,param:[String : Any], success:@escaping Successed,failure:@escaping Failured) {
        RestClient.sharedInstance.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        RestClient.sharedInstance.get(config.netApi + "api/" + request, parameters: param, success: { (task, responseObjc) in
            success(task,responseObjc)
        }) { (task, error) in
            failure(error)
        }
    }
    //.net POST 请求
    class func sendPostRequest(request: String,param:[String : Any], success:@escaping Successed,failure:@escaping Failured){
        RestClient.sharedInstance.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        RestClient.sharedInstance.post(config.netApi + "api/" + request, parameters: param, success: { (task, responseObjc) in
            success(task,responseObjc)
        }) { (task, error) in
            failure(error)
        }
    }
    //.net POST 上传图片请求
    class func sendPostUploadImageRequest(fileDatas:[Data],request: String,param:[String : Any], success:@escaping Successed,failure:@escaping Failured){
        RestClient.sharedInstance.requestSerializer.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        RestClient.sharedInstance.post(config.netApi + "api/" + request, parameters: param, constructingBodyWith: { (formatData) in
            Print.dlog("multipart/form-data ---------  constructingBodyWith")
            for data in fileDatas {
                formatData.appendPart(withFileData: data, name: "image", fileName: "file.jpg", mimeType: "image/png")
            }
        }, success: { (task, responseObjc) in
            success(task,responseObjc)
        }) { (task, error) in
            failure(error)
        }
    }
    //.net POST 上传语音请求
    class func sendPostUploadRecoderRequest(fileDatas:[Data],request: String,param:[String : Any], success:@escaping Successed,failure:@escaping Failured){
        RestClient.sharedInstance.requestSerializer.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        RestClient.sharedInstance.post(config.netApi + "api/" + request, parameters: param, constructingBodyWith: { (formatData) in
            Print.dlog("multipart/form-data ---------  constructingBodyWith")
            for data in fileDatas {
                formatData.appendPart(withFileData: data, name: "video", fileName: "file.mp3", mimeType: "application/octet-stream")
            }
        }, success: { (task, responseObjc) in
            success(task,responseObjc)
        }) { (task, error) in
            failure(error)
        }
    }
    
}

