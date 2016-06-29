//
//  AppDelegate.m
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/20.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "AppDelegate.h"
#import "GWPush.h"
#import "GWStatisticalUtil.h"
#import <IQKeyboardManager.h>
#import "JTBaseNavigationController.h"
#import "LoginViewController.h"
#import "DataVersionUtil.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


+(void)load{
    //键盘控制
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    application.applicationIconBadgeNumber = 0;//角标清零
    [[UIApplication sharedApplication] cancelAllLocalNotifications];//本地通知注销
    //
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //数据库部分
    [DataVersionUtil dataInit];
    
    //开启统计
    [GWStatisticalUtil openTheStatistics];
    //启动推送
    [GWPush openTheJPush:launchOptions];
    //语言设置
    [LanguageManager setLanguage:CHINESE];
    
    if ([GVUserDefaults standardUserDefaults].token) {//判断是否需要登陆
        UINavigationController *navi = [[JTBaseNavigationController alloc] initWithRootViewController:[[UIViewController alloc]init]];
        
        [navi setNavigationBarHidden:YES];
        [JTBaseNavigationController shareNavgationController].fullScreenPopGestureEnable = NO; //开启全屏返回手势
        self.window.rootViewController = navi;
    }else{
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
    [self.window makeKeyAndVisible];
    
        //引导页部分
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma -mark 注册上传deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [GWPush uploadDeviceToken:deviceToken];
}


#pragma -mark 前台收到远程通知的方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [GWPush handleRemoteNotification:userInfo application:application fetchCompletionHandler:completionHandler callBcak:^(NSDictionary *dict) {
        
    }];
}

#pragma -mark 前台收到本地通知的方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [GWPush handlelocadNotification:notification application:application callBcak:^(NSDictionary *dict) {
        
    }];
}

@end
