//
//  NSURLConnectionUtil.m
//  UI16_天气预报
//
//  Created by lanou on 15/7/4.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NSURLConnectionUtil.h"

@implementation NSURLConnectionUtil

+(NSMutableURLRequest *)requestWithURL:(NSString *)urlStr timeoutInterval:(NSTimeInterval)nsTimeInterval
{
    //utf-8编码
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    return  [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:nsTimeInterval];
}

@end
