//
//  LoginModel.h
//  BaseProject
//  主要用于存储登陆过会的一些用户缓存,单例模式
//
//  Created by xiaowen.chen on 16/6/21.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject


@property(strong,nonatomic)NSString *userName;
@property(strong,nonatomic)NSString *userToken;

+ (LoginModel *)sharedManager;


@end
