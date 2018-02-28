//
//  MainService.swift
//  Client
//
//  Created by Hengzhan on 2018/2/8.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MainService {
    static let config = Config()
    static let shared = MainService()
    /** 查询首页轮播图 **/
    func loadBanner(param:[String:Any], closure:@escaping ((Any) -> Void)) {
        RestAPI.sendGetRequest(request: N.Main_Gallery, param: param, success: { (task,data) in
            var json = JSON(data!)
            var urls = [String]()
            for (_,subjson) : (String,JSON) in json["Items"] {
                let ImageUrl = subjson["ImageUrl"].stringValue
                urls.append(ImageUrl)
            }
            closure(urls)
        }) { (error) in
            Print.dlog(error!)
        }
    }
    /** 查询产品类目 **/
    func loadMallType(param:[String:Any], closure:@escaping ((Any) -> Void)) {
        RestAPI.sendGetRequest(request: N.Main_ProductCategory, param: param, success: { (task,data) in
            var json = JSON(data!)
            var Id = ""
            for (index,subjson) : (String,JSON) in json["Items"] {
                if index == "0" {
                    Id = subjson["Id"].stringValue
                }
            }
            closure(Id)
        }) { (error) in
            Print.dlog(error!)
        }
    }
    /** 查询产品类目 **/
    func loadMallProduct(param:[String:Any], closure:@escaping ((Any) -> Void)) {
        RestAPI.sendGetRequest(request: N.Main_Product, param: param, success: { (task,data) in
            var json = JSON(data!)
            var products = [ProductModel]()
            for (_,subjson) : (String,JSON) in json["Items"] {
                let product = ProductModel()
                product.Name = subjson["Name"].stringValue
                product.UnitPrice = subjson["UnitPrice"].stringValue
                product.SmallImageUrl = subjson["SmallImageUrl"].stringValue
                products.append(product)
            }
            closure(products)
        }) { (error) in
            Print.dlog(error!)
        }
    }
    /** 查询视频咨询 **/
    func loadVideo(param:[String:Any], closure:@escaping ((Any) -> Void)) {
        RestAPI.sendGetRequest(request: N.Main_Video, param: param, success: { (task,data) in
            var json = JSON(data!)
            var videos = [VideoModel]()
            for (_,subjson) : (String,JSON) in json["Items"] {
                let video = VideoModel()
                video.Title = subjson["Title"].stringValue
                video.SmallImageUrl = subjson["SmallImageUrl"].stringValue
                video.VideoUrl = subjson["VideoUrl"].stringValue
                videos.append(video)
            }
            closure(videos)
        }) { (error) in
            Print.dlog(error!)
        }
    }
    /** 查询图片咨询 **/
    func loadPhoto(param:[String:Any], closure:@escaping ((Any) -> Void)) {
        RestAPI.sendGetRequest(request: N.Main_Article, param: param, success: { (task,data) in
            var json = JSON(data!)
            Print.dlog(json)
            var photoes = [PhotoModel]()
            for (_,subjson) : (String,JSON) in json["Items"] {
                let photo = PhotoModel()
                photo.Title = subjson["Title"].stringValue
                photo.SmallImageUrl = subjson["SmallImageUrl"].stringValue
                photo.VideoUrl = subjson["VideoUrl"].stringValue
                photoes.append(photo)
            }
            closure(photoes)
        }) { (error) in
            Print.dlog(error!)
        }
    }
}
