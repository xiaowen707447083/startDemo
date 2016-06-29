//
//  UserMacros.h
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/21.
//  Copyright © 2016年 xw.com. All rights reserved.
//

//用户名
#define CHECK_USER_NAME @"^[A-Za-z0-9]{6,20}+$"
//密码
#define CHECK_PASSWORD @"^[A-Za-z0-9]{6,20}+$"
//手机号码
#define CHECK_PHONE @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"
//邮箱
#define CHECK_EMALL @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//身份证
#define CHECK_ID @"^(\\d{14}|\\d{17})(\\d|[xX])$"