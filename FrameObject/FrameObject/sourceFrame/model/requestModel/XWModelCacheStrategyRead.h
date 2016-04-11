//
//  XWModelCacheStrategyRead.h
//  FrameObject
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWModelCacheStrategy.h"

@interface XWModelCacheStrategyRead : XWModelCacheStrategy

@property(assign,nonatomic)int cacheTime;//时间(单位s),-1表示强制读取,-2表示读取,其他情况表示缓存是否已经超过这个时间


@end
