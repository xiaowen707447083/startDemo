//
//  NSURLConnectionUtil.h
//  UI16_天气预报
//
//  Created by lanou on 15/7/4.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLConnectionUtil : NSObject

/**
 *  封装了utf-8编码格式
 *
 *  @param url            <#url description#>
 *  @param nsTimeInterval <#nsTimeInterval description#>
 *
 *  @return <#return value description#>
 */
+(NSMutableURLRequest *)requestWithURL:(NSString *)urlStr timeoutInterval:(NSTimeInterval)nsTimeInterval;

@end
