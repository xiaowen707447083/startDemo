//
//  NSString+Extension.m
//  测试textview放图片
//
//  Created by G-emall on 16/5/19.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSArray <NSTextCheckingResult *> *)machesWithPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error)
    {
        NSLog(@"正则表达式创建失败");
        return nil;
    }
    return [expression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    
}

@end
