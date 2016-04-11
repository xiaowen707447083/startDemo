//
//  ViewController.m
//  FrameObject
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    XWModelRequest *xw = [XWModelRequest modelWithName:@"api111"];
    //读策略
    xw.readStrategy = [[XWModelCacheStrategyRead alloc] init];
    //其他的处理方法
    XWModelOtherRequestDeal *otherDetail = [[XWModelOtherRequestDeal alloc] init];
    otherDetail.otherReq = ResultNotification;
    //方式对象
    XWModelRequestNotification *notRequest = [[XWModelRequestNotification alloc] init];
    notRequest.notificationName = @"系统通知名";
    otherDetail.obj = notRequest;
    
    xw.otherDeal = otherDetail;
    
    describe(xw)
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
