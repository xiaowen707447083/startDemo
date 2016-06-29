//
//  MyAFHTTPSessionManager.h
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/28.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface MyAFHTTPSessionManager : NSObject


+ (MyAFHTTPSessionManager *)sharedManager;


//获取链接
-(AFHTTPSessionManager *)getSessionManager;

//返回session链接
-(void)returnToSessionManager:(AFHTTPSessionManager *)sessionManager;

@end
