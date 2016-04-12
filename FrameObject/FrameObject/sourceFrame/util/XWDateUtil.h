//
//  XWDateUtil.h
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWDateUtil : NSObject

//获取多少天,多少小时,多少分钟,多少秒之后的时间
+(NSString *)getTimeAfterDay:(int)day hours:(int)hours min:(int)min ss:(int)ss fromDate:(NSDate *)date withForMet:(NSString *)forMet;


//时间转字符串
+(NSString *)strWithDate:(NSDate *)date withForMet:(NSString *)forMet;

@end
