//
//  BaseSqlUtil.m
//  FrameObject
//
//  Created by shenba on 16/4/13.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "BaseSqlUtil.h"

@implementation BaseSqlUtil

-(NSString *)getTableName{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

/*
 *根据请求条件获取一个对象
 */
-(NSMutableDictionary *)getSigleResultWithDictionary:(NSDictionary *)reqDic{
    
    NSMutableString *str = [NSMutableString stringWithString:@"select * from "];
    [str appendFormat:@"%@ where 1=1 ",[self getTableName]];
    
    for (NSString *temp in [reqDic allKeys]) {
        NSString *tempValue = [reqDic valueForKey:temp];
        if ([temp isEqualToString:@""]) {
            continue;
        }
        if ([tempValue isEqualToString:@""]) {
            continue;
        }
        [str appendFormat:@"and %@ = '%@' ",temp,tempValue];
    }
    [str appendString:@";"];
    
    NSDictionary *tempDic = [self getAttribute];
    NSMutableDictionary *result = [[MyFMDataManager sharedManager] queryPrimaryWithSql:str block:^(FMResultSet *set, NSMutableDictionary *dic) {
        for (NSString *temp in [tempDic allKeys]) {
            //NSString *tempValue = [tempDic valueForKey:temp];//目前只支持string类型的处理
            [dic setValue:[set stringForColumn:temp] forKey:temp];
        }
    }];
    return result;
}

/*
 *根据请求条件获取列表
 */
-(NSMutableArray *)getResultsWithDictionary:(NSDictionary *)reqDic{
    
    NSMutableString *str = [NSMutableString stringWithString:@"select * from "];
    [str appendFormat:@"%@ where 1=1 ",[self getTableName]];
  
    for (NSString *temp in [reqDic allKeys]) {
        NSString *tempValue = [reqDic valueForKey:temp];
        if ([temp isEqualToString:@""]) {
            continue;
        }
        if ([tempValue isEqualToString:@""]) {
            continue;
        }
        [str appendFormat:@"and %@ = '%@' ",temp,tempValue];
    }
    [str appendString:@";"];
    
    NSDictionary *tempDic = [self getAttribute];
    NSMutableArray *arr =[[MyFMDataManager sharedManager] queryResultsWithSqls:str block:^(FMResultSet *set, NSMutableDictionary *dic) {
        for (NSString *temp in [tempDic allKeys]) {
//            NSString *tempValue = [tempDic valueForKey:temp];//目前只支持string类型的处理
            [dic setValue:[set stringForColumn:temp] forKey:temp];
        }

    }];
    
    return arr;
}

/*
 *根据条件更新数据库数据
 */
-(void)updateDataBase:(NSDictionary *)resultDic withConditions:(NSDictionary *)conditionsDic{
    
    NSMutableString *mstr = [NSMutableString stringWithString:@"update "];
    [mstr appendFormat:@" %@ set 1 = 1 ",[self getTableName]];
    for (NSString *tempStr in resultDic) {
        [mstr appendFormat:@",%@='%@'",tempStr,[resultDic valueForKey:tempStr]];
    }
    [mstr appendString:@" where 1=1 "];
    for (NSString *tempStr in conditionsDic) {
        [mstr appendFormat:@"and %@ = '%@' ",tempStr,[conditionsDic valueForKey:tempStr]];
    }
    
    [[MyFMDataManager sharedManager] executeUpdateSql:mstr];
}

/*
 *根据对象更新数据库,唯一id作为标志
 */
-(void)updateDataBaseWithObject:(NSObject *)obj{
    
    NSLog(@"updateDataBaseWithObject该方法暂未实现");
    
}

/*
 *根据条件删除数据库数据
 */
-(void)deleteDataBaseWithConditions:(NSDictionary *)conditionsDic{
    
    NSMutableString *mstr = [NSMutableString stringWithString:@"delete from "];
    [mstr appendFormat:@" %@ where 1 = 1 ",[self getTableName]];
    
    NSArray *tempArr = [conditionsDic allKeys];
    for (NSString *tempStr in tempArr) {
        [mstr appendFormat:@"and %@ = '%@' ",tempStr,[conditionsDic valueForKey:tempStr]];
    }
    
    [[MyFMDataManager sharedManager] executeUpdateSql:mstr];
}

/*
 *根据对象删除数据库数据,唯一id为标志
 */
-(void)deleteDateBaseWithObject:(NSObject *)obj{
    
    int _id = [[obj valueForKey:@"_id"] intValue];
    NSString*sqlSelect=[NSString stringWithFormat:@"delete from %@ where id = %d",[self getTableName],_id];
    [[MyFMDataManager sharedManager] executeUpdateSql:sqlSelect];

}
/*
 *根据对象增加数据库数据
 */
-(void)addDataBaseWithObject:(NSObject *)obj{
    
    NSMutableString *mstr = [NSMutableString stringWithString:@"insert into "];
    [mstr appendFormat:@"%@(my_create_time",[self getTableName]];
    NSDictionary *tempDic = [self getAttribute];
    NSArray *tempKey = [tempDic allKeys];
    for (NSString *temp in tempKey) {
        [mstr appendFormat:@",%@",temp];
    }
    [mstr appendFormat:@")values('%@'",[XWDateUtil strWithDate:nil withForMet:nil]];
    for (NSString *temp in tempKey) {
        
        
        [mstr appendFormat:@",'%@'",[obj valueForKey:temp]];
    }
    [mstr appendString:@")"];
    
    [[MyFMDataManager sharedManager] executeUpdateSql:mstr];
}
/*
 *根据属性增加数据库数据
 */
-(void)adddataBaseWithConditions:(NSDictionary *)conditionsDic{
    
    NSMutableString *mstr = [NSMutableString stringWithString:@"insert into "];
    [mstr appendFormat:@"%@(my_create_time",[self getTableName]];
    NSArray *tempKey = [conditionsDic allKeys];
    for (NSString *temp in tempKey) {
        [mstr appendFormat:@",%@",temp];
    }
    [mstr appendFormat:@")values('%@'",[XWDateUtil strWithDate:nil withForMet:nil]];
    for (NSString *temp in tempKey) {
        [mstr appendFormat:@",'%@'",[conditionsDic valueForKey:temp]];
    }
    [mstr appendString:@")"];
    
    [[MyFMDataManager sharedManager] executeUpdateSql:mstr];
    
    
}

/*
 *建立数据库表
 */
-(void)createDataBaseTable{
    
    NSMutableString *str = [NSMutableString stringWithString:@"create table if not exists "];
    [str appendFormat:@"%@(id integer primary key autoincrement,my_create_time text",[self getTableName]];
    
    NSDictionary *tempDic = [self getAttribute];
    for (NSString *temp in [tempDic allKeys]) {
        NSString *tempValue = [tempDic valueForKey:temp];
        if ([temp isEqualToString:@""]) {
            continue;
        }
        if ([tempValue isEqualToString:@""]) {
            continue;
        }
        [str appendFormat:@",%@ %@",temp,tempValue];
    }
    
    
    [str appendString:@");"];
    [[MyFMDataManager sharedManager] executeUpdateSql:str];
}

/*
 *删除某个时间段之前的数据 入参:格式化字符串,格式类型
 */
-(void)deleteDateBaseWithTimesBefore:(NSString *)str forMet:(NSString *)forMet{
    NSLog(@"deleteDateBaseWithTimesBefore暂未实现");
}


@end
