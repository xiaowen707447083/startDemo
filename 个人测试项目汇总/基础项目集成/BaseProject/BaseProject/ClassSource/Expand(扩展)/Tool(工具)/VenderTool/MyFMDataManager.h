//
//  MyFMDataManager.h
//  UI17_数据库
//
//  Created by lanou on 15/7/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface MyFMDataManager : NSObject
//属性1
@property(nonatomic,strong)FMDatabase *db;




#pragma -mark -----------------  启动需要调用的方法  ------------------------

/**
 *  单例返回对象
 *
 *  @return <#return value description#>
 */
+ (MyFMDataManager *)sharedManager;

/**
 *  单例返回对象
 *
 *  @return <#return value description#>
 */
+ (MyFMDataManager *)sharedManager:(NSString *)dataName;

/*
 *是否首次启动数据库,使用:判断是否首次启动数据库,如果是的话,建立自己需要的表
 */
-(Boolean)isFirstRunDataBase;

/**
 *  判断数据库释放需要升级版本,如果需要的话进行数据库升级工作
 *
 *  @param version <#version description#>
 *  @param autoDate 如果是yes的话,调用该判断语句如果需要升级会自动修改数据库版本表
 *
 *  @return <#return value description#>
 */
-(BOOL)existsUpVersion:(NSString *)version andIsAutoUpdate:(Boolean)autoDate;


#pragma -mark -----------------  操作表的方法  ------------------------


/**
 *  数据库插入,更新,删除操作(单条语句)
 *
 *  @param sql 数据库语句
 *
 *  @return <#return value description#>
 */
-(BOOL)executeUpdateSql:(NSString *)sql;

/**
 *  数据库插入,更新,删除操作(多条语句)
 *
 *  @param sql 数据库语句
 *
 *  @return <#return value description#>
 */
-(BOOL)executeUpdateSqls:(NSArray *)sqls;


/**
 *  数据库查询,返回单条(唯一)结果
 *
 *  @param sql 数据库语句
 *
 *  @param handler 回调处理,用于填充数据
 *
 *  @return <#return value description#>
 */
-(NSMutableDictionary *)queryPrimaryWithSql:(NSString *)sql block:(void (^)(FMResultSet* set, NSMutableDictionary *dic)) handler NS_AVAILABLE(10_7, 5_0);

/**
 *  数据库查询,返回结果数组(里面存放字典)
 *
 *  @param sql 数据库语句
 *
 *  @param handler 回调处理,用于填充数据
 *
 *  @return <#return value description#>
 */
-(NSMutableArray *)queryResultsWithSqls:(NSString *)sql block:(void (^)(FMResultSet* set, NSMutableDictionary *dic)) handler NS_AVAILABLE(10_7, 5_0);


/**
 *  表添加字段(text类型的)
 *
 *  @param tableName  表名
 *  @param columnName 要添加的字段名
 *  @param columnType 要添加的字段类型
 *
 *  @return <#return value description#>
 */
-(BOOL)addTableColumnTableName:(NSString *)tableName columnName:(NSString *)columnName columnType:(NSString *)columnType;



#pragma -mark -----------------  其他可能要用到的方法  ------------------------




#pragma -mark 数据库切换,如果需要用到另外的数据可以,需要调用这个方法进行切换 ,这里需要注意:切换表的时候,数据库的升级需要额外写方法升级
/*
 *切换数据库
 */
-(void)changeDataBaseToStr:(NSString *)tar;


/**
 *  新建数据库并且返回(在Documents文件夹下创建)
 *
 *  @param name 数据库名
 *
 *  @return <#return value description#>
 */
-(FMDatabase *)createDataBase:(NSString *)name;


//数据库版本控制

/**
 *  设置当前数据库版本 格式参照 版本号+时间 如'1.0.0'
 *
 *  @param version <#version description#>
 *  @return <#return value description#>
 */
-(BOOL)setDataBaseVersion:(NSString *)version;

/**
 *  获取当前数据库版本
 *
 *  @return 版本信息 版本号+时间 如'1.0.0.20150201'
 */
-(NSString *)getDataBaseVersion;



@end
