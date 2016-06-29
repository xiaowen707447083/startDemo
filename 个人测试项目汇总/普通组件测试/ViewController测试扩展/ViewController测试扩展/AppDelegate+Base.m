//
//  AppDelegate+Base.m
//  ViewController测试扩展
//
//  Created by xiaowen.chen on 16/6/8.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "AppDelegate+Base.h"

@implementation AppDelegate (Base)


#pragma -mark 生命周期
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"Launched in background %d", application.applicationState);

    
    [UIApplication sharedApplication].applicationIconBadgeNumber =0;
    
    
    [self initJPushWithLanuchOptions:launchOptions];
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //子线程内部(耗时代码写在这里)
            sleep(2);
            //H回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //主线程内容
                [[NSNotificationCenter defaultCenter]postNotificationName:@"kJPFNetworkDidLoginNotification" object:nil];
            });
        });
    
    
    return YES;
}


#pragma -mark 前台收到本地通知的方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    if (application.applicationState == UIApplicationStateActive)
    {
        NSLog(@"在前台的时候收到本地通知的结果");
        return;
    }
    else
    {
        NSLog(@"点击本地通知触发");
    }
}

#pragma -mark 前台收到远程通知的方法

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    //在前台收到通知调用方法
    [JPUSHService handleRemoteNotification:userInfo];
    
    
    
    if (application.applicationState == UIApplicationStateActive)
    {
        NSLog(@"前台收到推送通知，触发本地通知方法");
        /*时间1秒后触发*/
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.1];
        
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        
        if (notification)
        {
            notification.fireDate = date;
            notification.timeZone = [NSTimeZone defaultTimeZone];
            notification.repeatInterval = 0;
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.alertBody =[NSString stringWithFormat:@"%@",userInfo[@"aps"][@"alert"]];
            NSDictionary *infoDic = @{@"GateWangname&":userInfo[@"aps"][@"alert"]};
            notification.userInfo = infoDic;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
        completionHandler(UIBackgroundFetchResultNewData);
    }
    else
    {
        NSLog(@"远程触发点击方法");
    }
}


#pragma -mark 极光推送部分

//极光推送初始化
-(void)initJPushWithLanuchOptions:(NSDictionary *)launchOptions{
    // 广告标识符（IDFA） 如果不需要使用IDFA，传nil.
    //    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
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
    //7dbdd40067dd4d1c2eede09b
    [JPUSHService setupWithOption:launchOptions appKey:@"04a243d38da93f2c33789623" channel:@"iOS" apsForProduction:NO advertisingIdentifier:nil];
    
    [JPUSHService resetBadge];
    NSLog(@"前台进入极光清零");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRemoteNotificationJPUSH:) name:@"kJPFNetworkDidLoginNotification" object:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //将device token转换为字符串
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    
    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
    
    //将deviceToken保存在NSUserDefaults
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //保存 device token 令牌,并且去掉空格
    NSString *replaceBlank = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [userDefaults setObject:replaceBlank forKey:@"DeviceToken"];
    [userDefaults synchronize];
    
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
    [JPUSHService registrationID];
}

- (void)handleRemoteNotificationJPUSH:(id)sender{
//    NSString *md5_save_key = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NEW_MAC];
    NSString *md5_save_key = @"my_alias";
    
    if (!md5_save_key) {//
        return;
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isPush"] isEqualToString:@"1"])
    {
        NSLog(@"别名已经设置过了--");
        return;
    }
    
    NSLog(@"开始设置别名--");//这个方法要在极光初始化过后，不然会检测不到后面的回调函数
    [JPUSHService setAlias:md5_save_key callbackSelector:@selector(tagsAliasCallback: tags: alias:) object:self];
    
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    if (iResCode == 0) {//设置别名成功
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isPush"];
        NSLog(@"别名设置成功--");
        return;
    }
    NSLog(@"别名设置失败--");
}



@end
