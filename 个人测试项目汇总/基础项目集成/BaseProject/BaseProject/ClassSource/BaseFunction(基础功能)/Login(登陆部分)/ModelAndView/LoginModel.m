//
//  LoginModel.m
//  BaseProject
//  主要用于存储登陆过会的一些用户缓存,单例模式
//
//  Created by xiaowen.chen on 16/6/21.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

+ (LoginModel *)sharedManager
{
    static LoginModel *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

@end
