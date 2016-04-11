//
//  XWModelCacheStrategyWrite.m
//  FrameObject
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWModelCacheStrategyWrite.h"

@implementation XWModelCacheStrategyWrite



-(void)describe{
    NSLog(@"策略时间:%d",_cacheTime);
    NSLog(@"策略类型:%lu",(unsigned long)super.cacheStrategy);
}

@end
