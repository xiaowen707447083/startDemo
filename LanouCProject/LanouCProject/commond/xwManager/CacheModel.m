//
//  CacheModel.m
//  ScheduleManager
//
//  Created by xiaowen on 15/7/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CacheModel.h"
#import "NSString+MyNSString.h"
#import "NSDate+MyDate.h"

@implementation CacheModel

/*
 初始化缓存体
 */
-(id)initWithKey:(NSString *)key nsData:(NSData *)data times:(NSInteger)times
{
    self = [super init];
    if (self) {
        _key = key;
        _data = data;
        _times = times;
        _writeTime = [[NSString alloc] initWithDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

/*
 判断缓存体是否已经失效
 */
-(BOOL)isOutOfTime
{

    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:[[NSDate alloc] initWithString:_writeTime dateFormatterStr:@"yyyy-MM-dd HH:mm:ss"]];//时间用大写HH,24小时制度进行计算
    if (time > _times) {
        return YES;
    }
    return NO;
}

@end
