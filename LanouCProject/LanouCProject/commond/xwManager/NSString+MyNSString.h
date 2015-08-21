//
//  NSString+MyNSString.h
//  第八天作业
//
//  Created by lanou on 15/6/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyNSString)

/**
 *  根据时间 格式字符串获取时间字符串
 *
 *  @param date   <#date description#>
 *  @param format <#format description#>
 *
 *  @return <#return value description#>
 */
-(id)initWithDate:(NSDate *)date format:(NSString *)format;

@end
