//
//  XWModelResponse.h
//  FrameObject
//
//  Created by shenba on 16/4/11.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWBaseModel.h"
#import "XWModelRequest.h"

@interface XWModelResponse : XWBaseModel

@property(strong,nonatomic)XWModelRequest *requestModel;

@property(strong,nonatomic)NSMutableDictionary *responseHead;//请求返回的头文件
@property(strong,nonatomic)NSData *resultData;//请求返回的结果


//获取请求的api
-(NSString *)getRequestApi;

@end
