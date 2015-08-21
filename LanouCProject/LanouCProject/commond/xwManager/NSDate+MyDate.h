//
//  NSDate+MyDate.h
//  UI16_天气预报
//
//  Created by lanou on 15/7/4.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MyDate)
// 格式化时间
// --年--月--日--时--分--秒
// 年 y
// 月 M
// 日 d
// 时 H 大写代表24小时 小写代表12小时制
// 分 m
// 秒 s


/**
 *  根据格式字符串 和时间字符串获取时间
 *
 *  @param dateStr          时间字符串
 *  @param dateFormatterStr 格式字符串
 *
 *  @return <#return value description#>
 */
-(id)initWithString:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr;

-(NSInteger)year;
-(NSInteger)month;
-(NSInteger)day;
-(NSInteger)minute;
-(NSInteger)hour;
-(NSInteger)second;

@end
