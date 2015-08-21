//
//  NSString+MyNSString.m
//  第八天作业
//
//  Created by lanou on 15/6/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NSString+MyNSString.h"

@implementation NSString (MyNSString)




-(id)initWithDate:(NSDate *)date format:(NSString *)format
{
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    self = [self init];
    if (self) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:format];
        self = [formatter stringFromDate:date];
    }
    return self;
}

@end
