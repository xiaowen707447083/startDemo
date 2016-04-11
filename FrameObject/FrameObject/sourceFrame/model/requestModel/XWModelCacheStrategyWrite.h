//
//  XWModelCacheStrategyWrite.h
//  FrameObject
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWModelCacheStrategy.h"

@interface XWModelCacheStrategyWrite : XWModelCacheStrategy

@property(assign,nonatomic)int cacheTime;//时间(单位s),-1表示强制覆盖,-2表示不写,其他情况表示缓存是否已经超过这个时间


@end
