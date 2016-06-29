//
//  GWPush.m
//  GZG_base
//
//  Created by 陈奕智 on 16/6/17.
//  Copyright © 2016年 wxp. All rights reserved.
//

#import "GWPush.h"
#import "JPUSHService.h"

#define CONFIGURATION  NO    //配置选项  YES表示启动   NO表示关闭
#define ALIASSET       NO    //别名设置  YES表示设置   NO表示不设置
#define APPKEY @"46f6ab4b44d287ab21ff8e5d"

@implementation GWPush


/**
 *  开启极光
 */
+(void)openTheJPush:(NSDictionary *)launchOptions{
    if (CONFIGURATION) {
        // 广告标识符（IDFA） 如果不需要使用IDFA，传nil.
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //可以添加自定义categories
            [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                              UIUserNotificationTypeSound |
                                                              UIUserNotificationTypeAlert)
                                                  categories:nil];
        } else {
            //categories 必须为nil
            [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                              UIRemoteNotificationTypeSound |
                                                              UIRemoteNotificationTypeAlert)
                                                  categories:nil];
        }
        [JPUSHService setupWithOption:launchOptions appKey:APPKEY channel:@"iOS" apsForProduction:NO];
        
        //前台进入极光清零
        [GWPush resetBadge];
    }
}



/*!
 * @abstract 上传 deviceToken
 */
+ (void)uploadDeviceToken:(NSData *)deviceToken{
    if (CONFIGURATION) {
        /*
         //将device token转换为字符串
         NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
         deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
         
         //将deviceToken保存在NSUserDefaults
         NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
         //保存 device token 令牌,并且去掉空格
         NSString *replaceBlank = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
         
         [userDefaults setObject:replaceBlank forKey:@"DeviceToken"];
         [userDefaults synchronize];
         */
        
        // Required
        [JPUSHService registerDeviceToken:deviceToken];
        [JPUSHService registrationID];
    }
}



/*!
 * @abstract 处理收到远程通知
 */
+ (void)handleRemoteNotification:(NSDictionary *)userInfo application:(UIApplication *)application fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler callBcak:(void (^)(NSDictionary *dict))callBack{
    if (CONFIGURATION) {
        //在前台收到通知调用方法
        [JPUSHService handleRemoteNotification:userInfo];
        
        if (application.applicationState == UIApplicationStateActive){
            DLog(@"前台收到推送通知，触发本地通知方法");
            /*时间1秒后触发*/
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.1];
            
            UILocalNotification *localNotification = [[UILocalNotification alloc]init];
            
            if (localNotification){
                localNotification.fireDate = date;
                localNotification.timeZone = [NSTimeZone defaultTimeZone];
                localNotification.repeatInterval = 0;
                localNotification.soundName = UILocalNotificationDefaultSoundName;
                localNotification.alertBody =[NSString stringWithFormat:@"%@",userInfo[@"aps"][@"alert"]];
                localNotification.userInfo = userInfo;
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            }
            completionHandler(UIBackgroundFetchResultNewData);
        }else{
            DLog(@"远程触发点击方法");
            if (callBack) {
                callBack(userInfo);
            }
        }
    }
}



/*!
 * @abstract 前台收到本地通知
 */
+ (void)handlelocadNotification:(UILocalNotification *)notification application:(UIApplication *)application callBcak:(void (^)(NSDictionary *dict))callBack{
    if (application.applicationState == UIApplicationStateActive){
        DLog(@"在前台的时候收到本地通知的结果");
        return;
    }else{
        DLog(@"点击本地通知触发");
        if (callBack) {
            callBack(notification.userInfo);
        }
    }
}



/*!
 * 设置别名
 */
+ (void)setPushAlias:(id)sender{
    if (ALIASSET) {
        //    NSString *md5_save_key = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NEW_MAC];
        NSString *md5_save_key = @"my_alias";
        
        if (!md5_save_key) {
            return;
        }
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"baseProject_pushAlias_key"] isEqualToString:md5_save_key]){
            NSLog(@"别名已经设置过了--");
            return;
        }
        
        NSLog(@"开始设置别名--");//这个方法要在极光初始化过后，不然会检测不到后面的回调函数
        [JPUSHService setAlias:md5_save_key callbackSelector:@selector(tagsAliasCallback: tags: alias:) object:self];
    }
}

#pragma mark - 通知设置别名回调方法
+ (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    if (iResCode == 0) {
        [[NSUserDefaults standardUserDefaults] setValue:alias forKey:@"baseProject_pushAlias_key"];
        NSLog(@"别名设置成功--保存");
        return;
    }
    NSLog(@"别名设置失败--");
}



/*!
 * 角标清零
 */
+ (void)resetBadge{
    [JPUSHService resetBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

@end
