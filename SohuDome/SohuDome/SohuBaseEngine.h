//
//  SohuBaseEngine.h
//  SohuDome
//
//  Created by lanou3g on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^sohuRequestSuccessBack)(id data);
typedef void (^sohuRequestFailedBack)(NSError *error);
@interface SohuBaseEngine : NSObject


+ (void)getFromURL:(NSString *)URLString params:(NSDictionary *)params withSuccess:(sohuRequestSuccessBack)success withFailure:(sohuRequestFailedBack)failure;


+ (void)postFromURL:(NSString *)URLString params:(NSDictionary *)params withSuccess:(sohuRequestSuccessBack)success withFailure:(sohuRequestFailedBack)failure;

@end
