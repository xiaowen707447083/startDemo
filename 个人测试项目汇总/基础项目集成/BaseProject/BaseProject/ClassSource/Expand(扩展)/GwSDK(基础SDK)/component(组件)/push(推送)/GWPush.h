//
//  GWPush.h
//  GZG_base
//
//  Created by 陈奕智 on 16/6/17.
//  Copyright © 2016年 wxp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GWPush : NSObject


/**
 *  开启极光
 */
+(void)openTheJPush:(NSDictionary *)launchOptions;


/*!
 * @abstract 上传 deviceToken
 */

+ (void)uploadDeviceToken:(NSData *)deviceToken;


/*!
 * @abstract 处理收到远程通知
 */
+ (void)handleRemoteNotification:(NSDictionary *)userInfo
                     application:(UIApplication *)application
          fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
                        callBcak:(void (^)(NSDictionary *dict))callBack;

/*!
 * @abstract 前台收到本地通知
 */
+ (void)handlelocadNotification:(UILocalNotification *)notification
                    application:(UIApplication *)application
                       callBcak:(void (^)(NSDictionary *dict))callBack;


/*!
 * 设置别名
 */
+ (void)setPushAlias:(id)sender;


/*!
 * 角标清零
 */
+ (void)resetBadge;




@end
