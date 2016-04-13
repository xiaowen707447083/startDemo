//
//  BaseSqlUtil.h
//  FrameObject
//
//  Created by shenba on 16/4/13.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseSqlUtil : NSObject

/*
 *获取属性对象集合
 *子类必须重写该方法,后面的方法才能执行
 */
-(NSDictionary *)getAttribute;

/*
 *获取表名
 *子类必须重写该方法,后面的方法才能执行
 */
-(NSString *)getTableName;

/*
 *根据请求条件获取一个对象
 */
-(NSMutableDictionary *)getSigleResultWithDictionary:(NSDictionary *)reqDic;

/*
 *根据请求条件获取列表
 */
-(NSMutableArray *)getResultsWithDictionary:(NSDictionary *)reqDic;

/*
 *根据条件更新数据库数据
 */
-(void)updateDataBase:(NSDictionary *)resultDic withConditions:(NSDictionary *)conditionsDic;

/*
 *根据对象更新数据库,唯一id作为标志
 */
-(void)updateDataBaseWithObject:(NSObject *)obj;

/*
 *根据条件删除数据库数据
 */
-(void)deleteDataBaseWithConditions:(NSDictionary *)conditionsDic;

/*
 *根据对象删除数据库数据,唯一id为标志
 */
-(void)deleteDateBaseWithObject:(NSObject *)obj;
/*
 *根据对象增加数据库数据
 */
-(void)addDataBaseWithObject:(NSObject *)obj;
/*
 *根据属性增加数据库数据
 */
-(void)adddataBaseWithConditions:(NSDictionary *)conditionsDic;

/*
 *建立数据库表
 */
-(void)createDataBaseTable;

/*
 *删除某个时间段之前的数据 入参:格式化字符串,格式类型
 */
-(void)deleteDateBaseWithTimesBefore:(NSString *)str forMet:(NSString *)forMet;


@end
