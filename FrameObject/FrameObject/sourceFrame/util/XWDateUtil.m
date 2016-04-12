//
//  XWDateUtil.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWDateUtil.h"

@implementation XWDateUtil

//获取多少天,多少小时,多少分钟,多少秒之后的时间
+(NSString *)getTimeAfterDay:(int)day hours:(int)hours min:(int)min ss:(int)ss fromDate:(NSDate *)date withForMet:(NSString *)forMet{
    
    if (date==nil) {
        date = [NSDate date];
    }
    
    NSDate *resultDate = [[NSDate alloc]initWithTimeInterval:(24 * 60 * 60)*day+(60*60)*hours+min*60+ss sinceDate:date];
    
    return [self strWithDate:resultDate withForMet:forMet];
    
}


//时间转字符串
+(NSString *)strWithDate:(NSDate *)date withForMet:(NSString *)forMet{
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:forMet];
    
    return  [df stringFromDate:date];
}

@end
