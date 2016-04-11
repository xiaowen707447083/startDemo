//
//  XWModelOtherRequestDeal.h
//  FrameObject
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWBaseModel.h"
#import "XWModelRequestNotification.h"


typedef enum : NSUInteger {
    NoDeal = 0,
    ResultNotification
} XWEnumOtherRequestDeal;

@interface XWModelOtherRequestDeal : XWBaseModel

@property(assign,nonatomic)XWEnumOtherRequestDeal otherReq;

@property(strong,nonatomic)NSObject *obj;

@end
