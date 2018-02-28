//
//  N.swift
//  Doctor
//
//  Created by Hengzhan on 2017/12/8.
//  Copyright © 2017年 Hengzhan. All rights reserved.
//

import Foundation
//.net 接口地址
struct N {
    /** 发送注册验证码 **/
    static let Login_SendMobileVerifyCode = "Account/SendMobileVerifyCode"
    /** 注册账号 **/
    static let Login_Register = "Account/Register"
    /** 找回密码 **/
    static let Login_ResetPassword = "Account/ResetPassword"
    /** 登录 **/
    static let Login_Login = "Account/Login"
    /** 修改密码 **/
    static let Login_SaveUser = "Account/SaveUser"
    /** 首页获取日历状态接口 **/
    static let Main_ReservationExpert = "Health/QueryReservationExpert"
    /** 首页获取预约专家回复接口 **/
    static let Main_ReservationExpertReply = "Health/QueryReservationExpertReply"
    /** 首页获取视频接口 **/
    static let Main_Video = "System/QueryVideo"
    /** 首页获取图片接口 **/
    static let Main_Article = "System/QueryArticle"
    /** 行程详情获取专家认证状态接口 **/
    static let Message_Expert = "Health/QueryExpert"
    
    /** 消息中心接口 **/
    static let Message_Record = "Message/QueryRecord"
    /** 消息列表接口 **/
    static let Message_Content = "Message/QueryContent"
    /** 回复消息接口 **/
    static let Message_SaveReservationExpertReply = "Health/SaveReservationExpertReply"
    /** 查询回复消息接口 **/
    static let Message_ReservationExpertReply = "Health/QueryReservationExpertReply"
    /** 建立客服聊天接口 **/
    static let Message_CreateSession = "CustomerService/CreateSession"
    /** 客服发送信息接口 **/
    static let Message_Send = "CustomerService/Send"
    /** 获取个人资料接口 **/
    static let Personal_User = "Account/QueryUser"
    /** 保存个人资料接口 **/
    static let Personal_SaveUser = "Account/SaveUser"
    /** 上传图片接口 **/
    static let Personal_UploadFile = "System/UploadFile"
    /** 保存个人主页接口接口 **/
    static let Personal_SaveExpert = "Health/SaveExpert"
    /** 获取健康档案数据接口 **/
    static let Health_HealthRecord = "Health/QueryHealthRecord"
    /** 获取健康档案编号数据接口 **/
    static let Health_HealthSuggestion = "Health/QueryHealthSuggestion"
    /** 保存健康建议接口 **/
    static let Health_SaveHealthSuggestion = "Health/SaveHealthSuggestion"
    /** 获取药用文件数据接口 **/
    static let Health_TakeMedicationRecord = "Health/QueryTakeMedicationRecord"
    /** 获取体脂数据接口 **/
    static let Health_FatDataV1 = "DeviceData/QueryFatDataV1"
    /** 获取血糖数据接口 **/
    static let Health_BGDataV1 = "DeviceData/QueryBGDataV1"
    /** 获取血氧数据接口 **/
    static let Health_Spo2DataV1 = "DeviceData/QuerySpo2DataV1"
    /** 获取体重数据接口 **/
    static let Health_WeightDataV1 = "DeviceData/QueryWeightDataV1"
    /** 获取血压数据接口 **/
    static let Health_BloodPressureV1 = "DeviceData/QueryBloodPressureV1"
    /** 获取尿常规数据接口 **/
    static let Health_URDataV1 = "DeviceData/QueryURDataV1"
    /** 获取血脂数据接口 **/
    static let Health_BD_FATDataV1 = "DeviceData/QueryBD_FATDataV1"
    /** 获取心电数据接口 **/
    static let Health_EcgStructV1 = "DeviceData/QueryEcgStructV1"
    /** 获取心电图片数据接口 **/
    static let Health_EcgPictureV1 = "DeviceData/QueryEcgPictureV1"
    
    /** 获取首页banner地址 **/
    static let Main_Gallery = "System/QueryGallery"
    /** 获取商品类别 **/
    static let Main_ProductCategory = "Mall/QueryProductCategory"
    /** 获取恒瑞推荐商品 **/
    static let Main_Product = "Mall/QueryProduct"
}
