//
//  GWStatisticalUtil.m
//  GZG_base
//
//  Created by G-emall on 16/5/26.
//  Copyright © 2016年 wxp. All rights reserved.
//


#import "GWStatisticalUtil.h"
#import "UMMobClick/MobClick.h"

@implementation GWStatisticalUtil

#define CONFIGURATION  NO    //配置选项  YES 表示无统计   NO表示友盟统计

/**
 *  开启统计的方法
 */
+ (void)openTheStatistics{
    if (CONFIGURATION) {
        //莲子统计

    }else{
        //友盟统计
        UMConfigInstance.appKey = @"574beeb067e58e70e3002848";
        [MobClick startWithConfigure:UMConfigInstance];
        [GWStatisticalUtil setCrashReportCollection:YES];  //是否提交程序异常报告
    }
}



/**
 *  在线更新参数
 */
+ (void)updateParameterOnline{
    if (CONFIGURATION) {

    }
}


/**
 *  设置app版本号。
 */
+(void)setAppVersionNumber:(NSString *)appVersion{
    if (CONFIGURATION) {
        
    }else{
        [MobClick setAppVersion:appVersion];
    }
}

/**
 *  开启CrashReport收集
 */
+(void)setCrashReportCollection:(BOOL)value{
    if (CONFIGURATION) {

    }else{
        [MobClick setCrashReportEnabled:value];
    }
}



/**
 *  事件统计
 *  event:   事件名
 *  tag:     事件描述
 */
+ (void)eventStatistics:(NSString *)event attributes:(NSDictionary *)dict{
    if (CONFIGURATION) {

    }else{
        [MobClick event:event attributes:dict];
    }
}


/**
 *  页面时长统计
 *  viewController：  当前的页面
 */
+ (void)onPageViewBegin:(UIViewController *)viewController{
    NSString *viewName = GetClass(viewController)
    
    if (CONFIGURATION) {
        
    }else{
        [MobClick beginLogPageView:viewName];
    }
    
}
+ (void)onPageViewEnd:(UIViewController *)viewController{
    NSString *viewName = GetClass(viewController)
    
    if (CONFIGURATION) {
       
    }else{
        [MobClick endLogPageView:viewName];
    }
}


#pragma mark 自定义统计部分
/**
 *  自定义统计方法
 *  customDictionary:     自定义统计所需的字典
 *  type            :     自定义类标记
 *
 */
+ (void)customEventStatistics:(NSDictionary *)customDictionary withType:(NSString *)type{
    //todo
}

@end
