//
//  UserMacros.h
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/21.
//  Copyright © 2016年 xw.com. All rights reserved.
//
#import <UIKit/UIKit.h>

//多语言
#define CHINESE         @"zh-Hans"
#define CHINESE_FAN     @"zh"
#define FOLLOW_SYSTEM   @"follow_system"
#define ENGLISH         @"en"

#define USER_LANGUAGE             @"user_language"   //用户语言





#define TextFiled_Color [UIColor colorWithRed:239.0/256 green:239.0/256 blue:239.0/256 alpha:1.0]


//判断ios系统版本
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES:NO)
#define notIOS8 [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0
#define notIOS9 [[[UIDevice currentDevice] systemVersion] floatValue] < 9.0
//获取类名
#define GetClass(cla) NSStringFromClass([cla class]);

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


#define UIAlert(a, b, c ,d) UIAlertView *at = [[UIAlertView alloc] initWithTitle:a message:b delegate:nil cancelButtonTitle:c otherButtonTitles:d, nil];\
[at show];

/*提醒框 自动消失*/
#define UIAlert_auto(b_titil,b_message,b_secord) __block UIAlertView *alert = [[UIAlertView alloc] initWithTitle:b_titil message:b_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];\
void(^DismissBlock)(void) = ^(void){\
[alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];\
};\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(b_secord * NSEC_PER_SEC)), dispatch_get_main_queue(),DismissBlock);\
[alert show];\
