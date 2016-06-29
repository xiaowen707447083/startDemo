//
//  BaseSqlUtil.m
//  FrameObject
//
//  Created by shenba on 16/4/13.
//  Copyright © 2016年 xiaowen. All rights reserved.
//
//  INTEGER
//  TEXT
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
    
    NSString *str = [self getSelectSql:reqDic];
    
    NSDictionary *tempDic = [self getAttribute];
    NSMutableDictionary *result = [[MyFMDataManager sharedManager] queryPrimaryWithSql:str block:^(FMResultSet *set, NSMutableDictionary *dic) {
        [self FillDictionary:dic attributes:tempDic set:set];
    }];
    return result;
}

//跟进数据库返回,组装数据
-(void)FillDictionary:(NSDictionary *)dic attributes:(NSDictionary *)attriDic set:(FMResultSet *)set{
    for (NSString *temp in [attriDic allKeys]) {
        NSString *clumnType = attriDic[temp];
        if ([clumnType isEqualToString:@"INTEGER"]) {
            [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:temp]] forKey:temp];
        }
        else if([clumnType isEqualToString:@"DOUBLE"]){
            [dic setValue:[NSString stringWithFormat:@"%f",[set doubleForColumn:temp]] forKey:temp];

        }
        else if([clumnType isEqualToString:@"DATETIME"]){
            [dic setValue:[set stringForColumn:temp] forKey:temp];

        }
        else{
            [dic setValue:[set stringForColumn:temp] forKey:temp];
        }
        
    }
}

/*
 *根据请求条件获取列表
 */
-(NSMutableArray *)getResultsWithDictionary:(NSDictionary *)reqDic{
    
    NSString *str = [self getSelectSql:reqDic];
    
    NSDictionary *tempDic = [self getAttribute];
    NSMutableArray *arr =[[MyFMDataManager sharedManager] queryResultsWithSqls:str block:^(FMResultSet *set, NSMutableDictionary *dic) {
        [self FillDictionary:dic attributes:tempDic set:set];

    }];
    
    return arr;
}


-(NSString *)getSelectSql:(NSDictionary *)reqDic{
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
        NSString *type = [self getTypeWithProperty:temp];
        if ([type isEqualToString:@"TEXT"]) {
            [str appendFormat:@"and %@ = '%@' ",temp,tempValue];
        }else if([type isEqualToString:@"DATETIME"]){
            
            if ([tempValue containsString:@","]){
                NSArray *tempArr = [tempValue componentsSeparatedByString:@","];
                for (NSString *strTemp in tempArr) {
                    [str appendFormat:@"and %@ %@ '%@' ",temp,[strTemp substringToIndex:1],[strTemp substringFromIndex:1]];
                }
            }else if ([tempValue containsString:@"<"] || [tempValue containsString:@">"] || [tempValue containsString:@"="]) {
                [str appendFormat:@"and %@ %@ '%@' ",temp,[tempValue substringToIndex:1],[tempValue substringFromIndex:1]];
            }else{
                [str appendFormat:@"and %@ = '%@' ",temp,tempValue];
            }
        }else{
            if ([tempValue containsString:@","]){
                NSArray *tempArr = [tempValue componentsSeparatedByString:@","];
                for (NSString *strTemp in tempArr) {
                    [str appendFormat:@"and %@ %@ %d ",temp,[strTemp substringToIndex:1],[[strTemp substringFromIndex:1] intValue]];
                }
            }else if ([tempValue containsString:@"<"] || [tempValue containsString:@">"] || [tempValue containsString:@"="]) {
                [str appendFormat:@"and %@ %@ %d ",temp,[tempValue substringToIndex:1],[[tempValue substringFromIndex:1] intValue]];
            }else{
                [str appendFormat:@"and %@ = %d ",temp,[tempValue intValue]];
            }
            
        }
    }
    [str appendString:@";"];
    
    return str;
}

/*
 *根据条件更新数据库数据 tood
 */
-(void)updateDataBase:(NSDictionary *)resultDic withConditions:(NSDictionary *)conditionsDic{
    
    NSMutableString *mstr = [NSMutableString stringWithString:@"update "];
    [mstr appendFormat:@" %@ set ",[self getTableName]];
    Boolean isfirst = YES;
    for (NSString *tempStr in resultDic) {
        
        if (isfirst) {
            isfirst = NO;
        }else{
            [mstr appendFormat:@","];
        }
        
        NSString *type = [self getTypeWithProperty:tempStr];
        if ([type isEqualToString:@"TEXT"]||[type isEqualToString:@"DATETIME"]) {
            [mstr appendFormat:@"%@='%@'",tempStr,[resultDic valueForKey:tempStr]];
        }else{
            [mstr appendFormat:@"%@=%d",tempStr,[[resultDic valueForKey:tempStr] intValue]];
        }
        
    }
    [mstr appendString:@" where 1=1 "];
    for (NSString *tempStr in conditionsDic) {
        
        NSString *type = [self getTypeWithProperty:tempStr];
        if ([type isEqualToString:@"TEXT"]||[type isEqualToString:@"DATETIME"]) {
            [mstr appendFormat:@"and %@ = '%@' ",tempStr,[conditionsDic valueForKey:tempStr]];
        }else{
            [mstr appendFormat:@"and %@ = %d ",tempStr,[[conditionsDic valueForKey:tempStr] intValue]];
        }
        
        
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
 *根据条件删除数据库数据 todo
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
 *根据对象增加数据库数据 todo
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
        
        NSString *type = [self getTypeWithProperty:temp];
        if ([type isEqualToString:@"TEXT"]||[type isEqualToString:@"DATETIME"]) {
            [mstr appendFormat:@",'%@'",[obj valueForKey:temp]];
        }else{
            [mstr appendFormat:@",%d",[[obj valueForKey:temp] intValue]];
        }
        
        
    }
    [mstr appendString:@")"];
    
    [[MyFMDataManager sharedManager] executeUpdateSql:mstr];
}
/*
 *根据属性增加数据库数据 todo
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
        
        NSString *type = [self getTypeWithProperty:temp];
        if ([type isEqualToString:@"TEXT"]||[type isEqualToString:@"DATETIME"]) {
            [mstr appendFormat:@",'%@'",[conditionsDic valueForKey:temp]];
        }else{
            [mstr appendFormat:@",%d",[[conditionsDic valueForKey:temp] intValue]];
        }
        
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
 *添加表属性
 */
-(BOOL)addTableColumnName:(NSString *)columnName columnType:(NSString *)columnType{
    return [[MyFMDataManager sharedManager] addTableColumnTableName:[self getTableName] columnName:columnName columnType:columnType];
}

/*
 *删除某个时间段之前的数据 入参:格式化字符串,格式类型
 */
-(void)deleteDateBaseWithTimesBefore:(NSString *)str forMet:(NSString *)forMet{
    NSLog(@"deleteDateBaseWithTimesBefore暂未实现");
}


//判断属性的格式
-(NSString *)getTypeWithProperty:(NSString *)property{
    
    NSDictionary *tempDic = [self getAttribute];
    for (NSString *temp in [tempDic allKeys]) {
        if ([temp isEqualToString:property]) {
            return [tempDic valueForKey:temp];
        }
    }
    return @"TEXT";
}

@end
