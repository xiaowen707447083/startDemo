//
//  modelRequest.swift
//  MyFrame
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

import UIKit

class ModelRequest: NSObject {
    //请求头
    var requestHead:Dictionary<String,String>;
    //请求体
    var requestBody:String = ""

    //读缓存策略
    var readStrategy:ModelCacheStrategyRead = ModelCacheStrategyRead()
    //写缓存策略
    var writeStrategy:ModelCacheStrategyWrite = ModelCacheStrategyWrite()
    //请求方式
    var type:EnumRequestType = EnumRequestType.POST
    
    //请求唯一标识(自定义)
    var userApi:String = ""
    //请求唯一标识(自动产生)
    var systemUUID:String = ""
    
    //其他请求处理策略对象
    var otherRequest:ModelOtherRequestDeal = ModelOtherRequestDeal()
    
    
    init(requestBody:String,userApi:String){
        self.requestBody = requestBody
        self.userApi = userApi;
        
        let date = NSDate()
        let timeInterval = date.timeIntervalSince1970 * 1000
        self.systemUUID = String(timeInterval)
        
    }
    
    func describe(){
//        print("type:"+type)
        print("userApi:"+userApi)
//        print("requestHead:"+requestHead)
        print("requestBody:"+requestBody)
//        print("readStrategy:"+readStrategy)
//        print("writeStrategy:"+writeStrategy)
        print("systemUUID:"+systemUUID)
//        print("otherRequest:"+otherRequest)
    }
}

//其他请求处理策略对象
class ModelOtherRequestDeal:NSObject {
    
    var dealType:EnumOtherRequestDeal = EnumOtherRequestDeal.NoDeal
    
    var objReal = nil //对象体
}

class ModelRequestNotification:NSObject {
    var notificationName:String = ""
    
}

enum EnumOtherRequestDeal:Int{
    case NoDeal = 0; //不做其他处理
    case ResultNotification; //发出处理通知
}


//枚举请求方式
enum EnumRequestType:Int{
    case GET = 0
    case POST
}


//缓存策略-基类
class ModelCacheStrategy:NSObject{
    var strategy:EnumCacheStrategy = EnumCacheStrategy.NoCache
}

//读策略
class ModelCacheStrategyRead:ModelCacheStrategy{
    var cacheTime:Int = -2//时间(单位s),-1表示强制读取,-2表示读取,其他情况表示缓存是否已经超过这个时间
    
}

//写策略
class ModelCacheStrategyWrite:ModelCacheStrategy{
    var cacheTime:Int = -2//时间(单位s),-1表示强制覆盖,-2表示不写,其他情况表示缓存是否已经超过这个时间
    
}

//策略枚举
enum EnumCacheStrategy:Int{
    case NoCache = 0//不缓存
    case Memory//内存
    case Disk//硬盘
    case SQL//数据库
    case MemoryAndDisk//内存和本地
    case MemoryAndSQL//内存和数据库
}