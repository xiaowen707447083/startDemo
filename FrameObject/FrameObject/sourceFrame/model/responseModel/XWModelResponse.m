//
//  XWModelResponse.m
//  FrameObject
//
//  Created by shenba on 16/4/11.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWModelResponse.h"

@implementation XWModelResponse

//获取请求的api
-(NSString *)getRequestApi{
    if (_requestModel!=nil) {
        return _requestModel.userApi;
    }
    return nil;
}

@end
