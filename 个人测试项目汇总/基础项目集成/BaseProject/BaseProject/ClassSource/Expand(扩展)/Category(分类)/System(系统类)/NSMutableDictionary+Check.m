//
//  NSMutableDictionary+Check.m
//
//  扩展在字典中加入相同的key,原理:如果字典中已经存在key,则把key变成key[标记]tag.
//  tag在方法中传入,循环加入中最好让他自动递增添加.
//
//  Copyright © 2016年 CXW All rights reserved.
//

#define RepeatCaptureTag @"__GW_REPEAT&__"

#import "NSMutableDictionary+Check.h"

@implementation NSMutableDictionary (Check)
- (void)setMyObject:(id)anObject forKey:(id<NSCopying>)aKey WithTag:(NSString*)tag
{
    if ([[self allKeys]indexOfObject:aKey]!=NSNotFound)
    {
        [self setObject:anObject forKey:[NSString stringWithFormat:@"%@%@",aKey,tag]];
    }
    else
    {
        [self setObject:anObject forKey:aKey];
    }

}

//写入字典，可重复key的扩展
- (void)setRepeatObject:(id)anObject forKey:(id<NSCopying>)aKey WithTag:(int)tag
{
    if ([[self allKeys] containsObject:aKey])
    {
        [self setObject:anObject forKey:[NSString stringWithFormat:@"%@%@%d",aKey,RepeatCaptureTag,tag]];
    }
    else
    {
        [self setObject:anObject forKey:aKey];
    }
    
}

//获取真实的value
-(id)valueForKey:(NSString *)key withTag:(int)tag{
    
    NSRange tempRange = [key rangeOfString:RepeatCaptureTag];
    if (tempRange.location>0) {
        key = [NSString stringWithFormat:@"%@%@%d",key,RepeatCaptureTag,tag];
    }
    
    return [self valueForKey:key];
}

#pragma mark 下面的方法是为了辅助

//获取真实的key
+(NSString *)getRealKeyWithStr:(NSString *)key{
    if (key!=nil) {
        NSArray *tempArr = [key componentsSeparatedByString:RepeatCaptureTag];
        return tempArr[0];
    }
    return key;
}

//获取标记
+(int)getRealTagWithStr:(NSString *)key{
    if (key!=nil) {
        NSArray *tempArr = [key componentsSeparatedByString:RepeatCaptureTag];
        if (tempArr.count>1) {
            return [tempArr[1] intValue];
        }
    }
    return -1;
}

+ (NSString*)getReallerWithName:(NSString*)beforeStr
{
    NSString *afterStr = beforeStr;
    if (beforeStr != nil && beforeStr.length > 3)
    {
        if ([beforeStr rangeOfString:RepeatCaptureTag options:NSCaseInsensitiveSearch].length>0)
        {
            afterStr = [beforeStr componentsSeparatedByString:RepeatCaptureTag][0];
            return afterStr;
        }
    }
    return afterStr;
}

@end
