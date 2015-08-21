//
//  CacheModel.h
//  ScheduleManager
//
//  Created by xiaowen on 15/7/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheModel : NSObject

@property(nonatomic,strong)NSString *writeTime;//写入时间
@property(nonatomic,strong)NSData *data;     //数据体
@property(nonatomic,assign)NSInteger times;  //存活时间
@property(nonatomic,strong)NSString *key;    //key

/*
 初始化缓存体
 */
-(id)initWithKey:(NSString *)key nsData:(NSData *)data times:(NSInteger)times;

/*
 判断缓存体是否已经失效
 */
-(BOOL)isOutOfTime;



@end
