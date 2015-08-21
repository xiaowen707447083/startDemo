//
//  ConfigPListTool.m
//  ScheduleManager
//
//  Created by lanou on 15/7/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ConfigPListTool.h"
#import "CacheModel.h"

@interface ConfigPListTool()

@property(nonatomic,strong)NSMutableDictionary *cacheDictionary;//缓存字典

@end

@implementation ConfigPListTool

static ConfigPListTool *sharedCommonInstance = nil;

//单例
+ (ConfigPListTool *)sharedManager
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedCommonInstance = [[self alloc] init];
        //初始化数组
        sharedCommonInstance.cofigDic = [NSMutableDictionary dictionary];
        sharedCommonInstance.cacheDictionary = [NSMutableDictionary dictionary];
        //
        
        //读取plist文件
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MyConfig" ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        [sharedCommonInstance.cofigDic setValuesForKeysWithDictionary:data];
    });
    
    return sharedCommonInstance;
}

//获取配置信息
-(NSString *)getConfig:(NSString *)key
{
    NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
    if ([de valueForKey:key]!= nil) {
        return [de valueForKey:key];
    }
    //如果是第一次启动的话回去plist文件读取配置
    return [self.cofigDic valueForKey:key];
}

/**
 *  写入配置数据
 *
 *  @param value ;
 *  @param key   <#key description#>
 */
-(void)setConfigValue:(NSString *)value forKey:(NSString *)key
{
    //写入配置数组
    [self.cofigDic setValue:value forKey:key];
    //写入本地
    NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
    [de setValue:value forKey:key];
    
}


//重写allocWithZone
+(id)allocWithZone:(struct _NSZone *)zone
{
    if (sharedCommonInstance == nil) {
        return [super allocWithZone:zone];
    }
    return nil;
}
/**
 *  读取缓存数据
 *
 *  @param key
 *
 *  @return value
 */
-(NSData *)getCache:(NSString *)key
{

   CacheModel *tempModel  = [self.cacheDictionary objectForKey:key];
    
    if (tempModel == nil) {
        return nil;
    }else if ([tempModel isOutOfTime]) {
        //移除缓存
         [self.cacheDictionary setValue:nil forKey:key];
        return nil;
    }else{
        NSLog(@"读取缓存-->%@",key);
        return tempModel.data;
    }
}

/**
 *  写入缓存数据
 *
 *  @param key
 *  @param data 数据
 *  @param times 存活时间
 *
 *  @return value
 */
-(void)setCache:(NSString *)key nsData:(NSData *)data times:(NSInteger)times
{
    NSLog(@"加入缓存-->%@",key);
    
    CacheModel *model =[[CacheModel alloc]initWithKey:key nsData:data times:times];
    
    [self.cacheDictionary setValue:model forKey:key];

}

@end
