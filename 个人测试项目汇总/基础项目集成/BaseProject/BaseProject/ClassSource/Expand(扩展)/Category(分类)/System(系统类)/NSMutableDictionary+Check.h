//
//  NSMutableDictionary+Check.m
//
//  扩展在字典中加入相同的key,原理:如果字典中已经存在key,则把key变成key[标记]tag.
//  tag在方法中传入,循环加入中最好让他自动递增添加.
//
//  Copyright © 2016年 CXW All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Check)

- (void)setMyObject:(id)anObject forKey:(id<NSCopying>)aKey WithTag:(NSString*)tag;
+ (NSString*)getReallerWithName:(NSString*)beforeStr;
@end
