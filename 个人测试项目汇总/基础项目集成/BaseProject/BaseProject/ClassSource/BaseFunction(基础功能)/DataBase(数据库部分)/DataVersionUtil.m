//
//  DataVersionUtil.m
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/24.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "DataVersionUtil.h"
#import "LoginInfoTable.h"

@implementation DataVersionUtil

+(void)dataInit{
    MyFMDataManager *manage = [MyFMDataManager sharedManager:nil];
    
    
    //切换数据库之后怎么操作
    if ([manage isFirstRunDataBase]) {
        //首次启动数据库
        [[[LoginInfoTable alloc] init] createDataBaseTable];

    };
    
    if ([manage existsUpVersion:@"1.0.1" andIsAutoUpdate:NO]) {
        //登陆信息表
        
    }
    
}

@end
