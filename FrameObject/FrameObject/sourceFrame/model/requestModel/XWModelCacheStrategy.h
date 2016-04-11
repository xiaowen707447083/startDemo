//
//  XWModelCacheStrategy.h
//  FrameObject
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWBaseModel.h"


typedef enum : NSUInteger {
    NoCache = 0,//不缓存
    Memory,//内存
    Disk,//本地
    SQL,//数据库
    MemoryAndDisk,//内存和本地
    MemoryAndSQL//内存和数据库
} XWEnumCacheStrategy;

@interface XWModelCacheStrategy : XWBaseModel

@property(assign,nonatomic)XWEnumCacheStrategy cacheStrategy;

@end
