//
//  LoginInfoTable.m
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/24.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "LoginInfoTable.h"

@implementation LoginInfoTable

-(NSDictionary *)getAttribute{
    
    return @{
             @"name":@"TEXT",
             @"mid":@"TEXT",
             @"age":@"INTEGER",
             @"address":@"TEXT",
             @"phoneNumber":@"TEXT",
             @"weight":@"DOUBLE",
             @"birthDay":@"DATETIME"
             };
    
}

@end
