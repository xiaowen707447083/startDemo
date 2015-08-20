//
//  AFDataModelRequest.m
//  SohuDome
//
//  Created by lanou3g on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "AFDataModelRequest.h"
#import "AFHTTPRequestOperation.h"
#import "MovieBaseInfo.h"
#import "SohuBaseEngine.h"
#import "SohuRequestURL.h"
#import "MovieDetailInfo.h"


#define SYD_URL @"index_lists.php?v=1.8.2"
#define LB_URL @"index_focus.php?v=1.8.2"
#define FL_URL @"channel.php?v=1.7.0"
#define FLMK_URL @"topics/index.json?v=1.8.2"
#define SEACH_URL @"&v=1.8.2&order=&offset=0&limit=30&v=1.8.2"

@implementation AFDataModelRequest


-(void)requestMovieBaseInfoWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure
{
    
    [SohuBaseEngine getFromURL:[SohuRequestURL SohuRequestURLString:SYD_URL] params:dic withSuccess:^(id data) {
        NSError *error;
        if (data != nil) {
        id dat = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        successWithData([self dataTransforWithSourceData:dat]);
        }else
        {
            failure(DE_DATA_CHECK_ERROR);
        }
        
    } withFailure:^(NSError *error) {
        
        failure(NET_ERROR);
    }];
    
    
}


-(NSArray *)dataTransforWithSourceData:(id)data
{
   
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i= 0; i < [data count] ; i++) {
        NSArray *arrays = [data[i] objectForKey:@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in arrays) {
            MovieBaseInfo *info = [[MovieBaseInfo alloc] initWithDictionary:dic];
            [array addObject:info];
        }
       [array addObject:[data[i] objectForKey:@"title"]];
       [dataArray addObject:array];

    }
   
    return dataArray;
    
}



-(void)requestCarouselFigureViewImage:(NSDictionary *)dic success:(void(^)(NSArray *imageArray))successWithData failed:(void(^)(DataErrorType type))failure
{
    
     [SohuBaseEngine getFromURL:[SohuRequestURL SohuRequestURLString:LB_URL] params:dic withSuccess:^(id data) {
         if (data != nil) {
              NSError *error;
              id dat = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             successWithData([self dataTransforWithSourceImageData:dat]);
         }else
         {
             failure(DE_DATA_CHECK_ERROR);
         }
 
         
         
     } withFailure:^(NSError *error) {
         
     }];
}

-(NSArray *)dataTransforWithSourceImageData:(id)data
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        MovieBaseInfo *info = [[MovieBaseInfo alloc] initWithDictionary:dic];
        [array addObject:info];
    }
    
    return array;
    
}

-(void)requestMovieClassifyInfoWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure
{
    [SohuBaseEngine getFromURL:[SohuRequestURL SohuRequestURLString:FL_URL] params:dic withSuccess:^(id data) {
        if (data != nil) {
            NSError *error;
            id dat = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

            successWithData([self dataTransforWithClassifyInfoSourceData:dat]);
        }else
        {
            failure(DE_DATA_CHECK_ERROR);
        }
        
    } withFailure:^(NSError *error) {
        
        failure(NET_ERROR);
    }];
 
}

-(void)requestMovieClassifyInfoDownWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure{
    [SohuBaseEngine getFromURL:[SohuRequestURL SohuRequestURLString:FLMK_URL] params:dic withSuccess:^(id data) {
        if (data != nil) {
            NSError *error;
            id dat = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

            successWithData([self dataTransforWithClassifyInfoSourceData:dat]);
        }else
        {
            failure(DE_DATA_CHECK_ERROR);
        }
        
    } withFailure:^(NSError *error) {
        
        failure(NET_ERROR);
    }];

    
    
}

-(NSArray *)dataTransforWithClassifyInfoSourceData:(id)data
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        MovieClassifyInfo *info = [[MovieClassifyInfo alloc] initWithDictionary:dic];
        [array addObject:info];
    }
    
    return array;
    
}


-(void)requestMovieBaseInfoListWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure
{
    
    [SohuBaseEngine getFromURL:[dic objectForKey:@"url"] params:nil withSuccess:^(id data) {
        if (data != nil) {
            NSError *error;
            id dat = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

            successWithData([self dataTransforListWithSourceData:dat]);
        }else
        {
            failure(DE_DATA_CHECK_ERROR);
        }
        
    } withFailure:^(NSError *error) {
        
        failure(NET_ERROR);
    }];
    
    
}


-(NSArray *)dataTransforListWithSourceData:(id)data
{
     NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        MovieBaseInfo *info = [[MovieBaseInfo alloc] initWithDictionary:dic];
        [array addObject:info];
    }
    
    return array;
    
}


-(void)requestMovieSearchWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure
{
    [SohuBaseEngine getFromURL:[SohuRequestURL SohuRequestURLString:[NSString stringWithFormat:@"search.php?q=%@%@",[dic objectForKey:@"url"],SEACH_URL]] params:nil withSuccess:^(id data) {
        if (data != nil) {
            NSError *error;
            id dat = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            successWithData([self dataTransforListWithSourceData:dat]);
        }else
        {
            failure(DE_DATA_CHECK_ERROR);
        }
        
    } withFailure:^(NSError *error) {
        
        failure(NET_ERROR);
    }];

    
}


-(void)requestMovieDetailWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure
{
    [SohuBaseEngine getFromURL:[SohuRequestURL SohuRequestURLString:[NSString stringWithFormat:@"detail.php?id=%@&v=1.7.0",[dic objectForKey:@"ID"]]] params:nil withSuccess:^(id data) {
        if (data != nil) {
            NSError *error;
            id dat = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            successWithData([self dataTransforDetailWithSourceData:dat]);
        }else
        {
            failure(DE_DATA_CHECK_ERROR);
        }
        
    } withFailure:^(NSError *error) {
        
        failure(NET_ERROR);
    }];
    

    
    
}

-(NSArray *)dataTransforDetailWithSourceData:(id)data
{
    NSMutableArray *array = [NSMutableArray array];
        MovieDetailInfo *info = [[MovieDetailInfo alloc] initWithDictionary:(NSDictionary *)data];
        [array addObject:info];
    
    return array;
    
}

@end
