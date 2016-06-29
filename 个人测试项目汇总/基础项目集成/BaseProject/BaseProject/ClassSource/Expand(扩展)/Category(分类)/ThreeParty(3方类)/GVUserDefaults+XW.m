//
//  GVUserDefaults+XW.m
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/21.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "GVUserDefaults+XW.h"

@implementation GVUserDefaults (XW)

@dynamic token;
@dynamic username;

/**
 *  恢复默认值
 */
+(void)revertUserDefaults{
    //
    [GVUserDefaults standardUserDefaults].token = nil;
    [GVUserDefaults standardUserDefaults].username = nil;

}

@end
