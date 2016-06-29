//
//  LoginInfoTable.h
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/24.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "BaseSqlUtil.h"

@interface LoginInfoTable : BaseSqlUtil


@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *mid;
@property(nonatomic,assign)int age;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *phoneNumber;
@property(nonatomic,assign)float weight;
@property(nonatomic,strong)NSString *birthDay;
@end
