//
//  MyFMDataManager.m
//  UI17_数据库
//
//  Created by lanou on 15/7/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MyFMDataManager.h"

@interface MyFMDataManager()

@property(nonatomic,strong)NSString *currentDataBaseTarg;//当前数据库标志
@property(nonatomic,strong)NSObject *obj;

@end


@implementation MyFMDataManager


/**
 *  单例返回对象
 *
 *  @return <#return value description#>
 */
+ (MyFMDataManager *)sharedManager{
    return [self sharedManager:nil];
}

+ (MyFMDataManager *)sharedManager:(NSString *)dataName
{
    static MyFMDataManager *sharedMyFMDataManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedMyFMDataManagerInstance = [[self alloc] init];
        sharedMyFMDataManagerInstance.db = [sharedMyFMDataManagerInstance createDataBase:dataName];
        sharedMyFMDataManagerInstance.obj = [[NSObject alloc]init];
    });

    return sharedMyFMDataManagerInstance;
}

/*
 *是否首次启动数据库
 */
-(Boolean)isFirstRunDataBase{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *result = [userDefaults valueForKey:@"isFirstRunDataBase"];
    if ([@"1" isEqualToString:result]) {
        return NO;
    }else{
        [userDefaults setValue:@"1" forKey:@"isFirstRunDataBase"];
        [self createVersionTabel];//创建数据库版本表1.0.0
        [self setDataBaseVersion:@"1.0.0"];
        return YES;
    }
}

//数据库环境控制
/*
 *切换数据库
 */
-(void)changeDataBaseToStr:(NSString *)tar{
    if ([tar isEqualToString:_currentDataBaseTarg]) {
        //无效的切换
        return;
    }
    _db = [self createDataBase:tar];
}



//NSLog(@"%@",NSHomeDirectory());
//建立数据库
-(FMDatabase *)createDataBase:(NSString *)name
{
    
    if (name == nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        name = [userDefaults valueForKey:@"schedule_database_targ"];
        
    }
    if (name == nil || [name isEqualToString:@""]) {
        _currentDataBaseTarg = @"pro";
        //首次安装的时候会走这个
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:@"pro" forKey:@"schedule_database_targ"];
        name = @"pro_schedule_database.sqlite";
    }else{
        _currentDataBaseTarg = name;
        name = [NSString stringWithFormat:@"%@_schedule_database.sqlite",name];
    }
    
    //在document文件夹下创建一个数据库 名字为students.sqlite
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *douPath = [arr lastObject];
    
    //创建数据库路径
    NSString *dbPath = [douPath stringByAppendingPathComponent:name];
    return [FMDatabase databaseWithPath:dbPath];
}

//建表
//NSString *sqlCreateTable = @"create table if not exists student (id integer primary key autoincrement,name text, sex text,age integer,address text)";
//[MyFMDataManager executeUpdate:db sql:sqlCreateTable];
//插入数据
//NSString *sqlInsert = [NSString stringWithFormat:@"insert into student (name,sex,age,address) values ('%@','%@',%d,'%@')",@"小明",@"男",11,@"广州"];
//[MyFMDataManager executeUpdate:db sql:sqlInsert];
-(BOOL)executeUpdateSql:(NSString *)sql;
{
    
    BOOL result = NO;
    @synchronized(_obj){
        if ([_db open]) {
            //语句执行
            result = [_db executeUpdate:sql];
        }
        [_db close];
    }
    
    return result;
}

-(BOOL)executeUpdateSqls:(NSArray *)sqls;
{
    BOOL result = NO;
    @synchronized(_obj){
        if ([_db open]) {
            //语句执行
            for (NSString *temp in sqls) {
                result = [_db executeUpdate:temp];
            }
        }
        [_db close];
    }
    
    return result;
}

//查找单条数据语句
//NSString *sqlQuery = @"select * from student where name = '小明'";
//NSDictionary *temdic = [MyFMDataManager queryPrimary:db sql:sqlQuery block:^(FMResultSet *set, NSMutableDictionary *dic) {
//    [dic setValue:[set stringForColumn:@"name"] forKey:@"name"];
//    [dic setValue:[set stringForColumn:@"name1"] forKey:@"name1"];
//    [dic setValue:[set stringForColumn:@"sex"] forKey:@"sex"];
//    [dic setValue:[set stringForColumn:@"age"] forKey:@"age"];
//    [dic setValue:[set stringForColumn:@"address"] forKey:@"address"];
//}];
-(NSMutableDictionary *)queryPrimaryWithSql:(NSString *)sql block:(void (^)(FMResultSet* set, NSMutableDictionary *dic)) handler NS_AVAILABLE(10_7, 5_0)
{
   
    if(DEBUG){
        NSLog(@"查找单条数据SQL:%@",sql);
    }
    
    NSMutableDictionary *dic = nil;
    @synchronized(_obj){
    
        if ([_db open]) {
            //语句执行
            FMResultSet *set = [_db executeQuery:sql];
            while ([set next]) {
                dic = [NSMutableDictionary dictionary];
                handler(set, dic);//回调的使用
                break;
            }
        }
        [_db close];
    }
   
    return dic;
}

//查找多条数据语句
-(NSMutableArray *)queryResultsWithSqls:(NSString *)sql block:(void (^)(FMResultSet* set, NSMutableDictionary *dic)) handler NS_AVAILABLE(10_7, 5_0)
{
    
    if(DEBUG){
        NSLog(@"查找多条数据SQL:%@",sql);
    }
    
    NSMutableArray *arr = [NSMutableArray array];
   
    @synchronized(_obj){
        if ([_db open]) {
            //语句执行
            FMResultSet *set = [_db executeQuery:sql];
            while ([set next]) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                handler(set, dic);
                [arr addObject:dic];
            }
        }
        [_db close];
    }
    
    return arr;
}

/**
 *  表添加字段
 */
-(BOOL)addTableColumnTableName:(NSString *)tableName columnName:(NSString *)columnName columnType:(NSString *)columnType
{
    NSString *sqlAlterTable = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", tableName, columnName,columnType];//添加表字段
    
    BOOL result = NO;
     @synchronized(_obj){
         if ([_db open]) {
             //语句执行
             result = [_db executeUpdate:sqlAlterTable];
         }
         [_db close];
     }
    
    return result;
}

/**
 *  建立数据库版本表
 *
 */
-(BOOL)createVersionTabel
{
    
    
    BOOL result = NO;
    @synchronized(_obj){
        
        [self changeDataBaseToStr:@"pro"];
        
        if ([_db open]) {
            NSString *sqlCreateTable = @"create table if not exists sofe_version(id integer primary key autoincrement,version text)";
            
            BOOL result = [_db executeUpdate:sqlCreateTable];
            if (result) {
                NSLog(@"建立version表成功");
                result = YES;
            }else{
                NSLog(@"建立version表失败");
            }
            [_db close];
        }
        
        [self changeDataBaseToStr:_currentDataBaseTarg];
    }
   
    
    
    return result;
}

/**
 *  设置当前数据库版本 格式参照 版本号 如'1.0.0'
 *
 */
-(BOOL)setDataBaseVersion:(NSString *)version
{
    //获取当前时间支付串
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyyMMdd"];
    NSString *tempDate = [forMatter stringFromDate:[NSDate date]];
    
    BOOL result = NO;
    @synchronized(_obj){
        
        [self changeDataBaseToStr:@"pro"];
        
        if ([_db open]) {
            NSString *sqlCreateTable = [NSString stringWithFormat:@"insert into sofe_version(version) values ('%@')",[NSString stringWithFormat:@"%@.%@",version,tempDate]];
            
            BOOL result = [_db executeUpdate:sqlCreateTable];
            if (result) {
                NSLog(@"添加version信息成功");
                result = YES;
            }else{
                NSLog(@"添加version信息失败");
            }
            [_db close];
        }

        [self changeDataBaseToStr:_currentDataBaseTarg];
    
    }
        return result;
}

/**
 *  获取当前数据库版本
 *
 *  @return 版本信息 版本号+时间 如'1.0.0.20150201'
 */
-(NSString *)getDataBaseVersion
{
    [self changeDataBaseToStr:@""];
    
    NSString *str = nil;
    @synchronized(_obj){
        
        [self changeDataBaseToStr:@"pro"];
    
        if ([_db open]) {
            NSString *sqlSelect = @"select *from sofe_version order by id desc";
            FMResultSet *set = [_db executeQuery:sqlSelect];
            while ([set next]) {
                str = [set stringForColumn:@"version"];
                [_db close];
                return str;
            }
        }
        [_db close];
        
        [self changeDataBaseToStr:_currentDataBaseTarg];
    
    }
    
    return str;
}


/**
 *  判断数据库释放需要升级版本,如果需要的话进行数据库升级工作
 *
 *  @param version <#version description#>
 *  @param autoDate 如果是yes的话,调用该判断语句如果需要升级会自动修改数据库版本表
 *
 *  @return <#return value description#>
 */
-(BOOL)existsUpVersion:(NSString *)version andIsAutoUpdate:(Boolean)autoDate{
    
    Boolean result = [self existsUpVersion:version];
    if (result) {
        if (autoDate) {
            [self setDataBaseVersion:version];
        }
    }
    return result;
}

/**
 *  判断数据库释放需要升级版本
 *  @return <#return value description#>
 */
-(BOOL)existsUpVersion:(NSString *)version
{
    NSString *temp = [self getDataBaseVersion];
    NSArray *ar1 = [version componentsSeparatedByString:@"."];
    NSArray *ar2 = [temp componentsSeparatedByString:@"."];
    if ([ar1 count] >= 3) {
        if ([ar1[0] integerValue] > [ar2[0] integerValue]) {
            return YES;
        }else if([ar1[0] integerValue] == [ar2[0] integerValue]){
            if ([ar1[1] integerValue] > [ar2[1] integerValue]) {
                return YES;
            }else if([ar1[1] integerValue] == [ar2[1] integerValue]){
                if ([ar1[2] integerValue] > [ar2[2] integerValue]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}




@end
