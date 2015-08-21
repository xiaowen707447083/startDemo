//
//  ConfigPListTool.h
//  ScheduleManager
//
//  Created by lanou on 15/7/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ConfigPListTool : NSObject

/*
 *用户对象,主要用于存放app运行过程中的一些全局参数
 */
@property(nonatomic,strong)NSMutableDictionary *cofigDic;




/**
 *  单例获取对象
 *
 *  @return 单例对象
 */
+ (ConfigPListTool *)sharedManager;

/**
 *  读取配置数据
 *
 *  @param key
 *
 *  @return value
 */
-(NSString *)getConfig:(NSString *)key;

/**
 *  写入配置数据
 *
 *  @param value <#value description#>
 *  @param key   <#key description#>
 */
-(void)setConfigValue:(NSString *)value forKey:(NSString *)key;


/**
 *  读取缓存数据
 *
 *  @param key
 *
 *  @return value
 */
-(NSData *)getCache:(NSString *)key;

/**
 *  写入缓存数据
 *
 *  @param key
 *  @param data 数据
 *  @param times 存活时间
 *
 *  @return value
 */
-(void)setCache:(NSString *)key nsData:(NSData *)data times:(NSInteger)times;



@end
