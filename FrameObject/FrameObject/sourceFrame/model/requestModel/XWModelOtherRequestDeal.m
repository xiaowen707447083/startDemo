//
//  XWModelOtherRequestDeal.m
//  FrameObject
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWModelOtherRequestDeal.h"

@implementation XWModelOtherRequestDeal

-(void)describe{
    
    NSLog(@"方式:%lu",(unsigned long)_otherReq);
    NSLog(@"对象体{");
    if (_otherReq == ResultNotification) {
        describe(_obj);
    }
    NSLog(@"}");
}

@end
