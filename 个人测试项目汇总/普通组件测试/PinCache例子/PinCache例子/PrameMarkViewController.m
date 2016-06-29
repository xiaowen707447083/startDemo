//
//  PrameMarkViewController.m
//  PinCache例子
//
//  Created by xiaowen.chen on 16/5/31.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "PrameMarkViewController.h"

@interface PrameMarkViewController ()

@end

@implementation PrameMarkViewController


#pragma -mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a = 3;
    
    
    (a > 3) ? (a = 1) : (a = 2);
    
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma -mark 自定义实现方法
#pragma -mark action方法
#pragma -mark 网络请求方法
#pragma -mark public公共方法
#pragma -mark private私有方法
#pragma -mark ***delegate/dataSource






@end
