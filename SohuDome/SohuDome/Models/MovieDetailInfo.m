//
//  MovieDetailInfo.m
//  VideoText
//
//  Created by 吴艳磊 on 15/6/8.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "MovieDetailInfo.h"

@implementation MovieDetailInfo


-(void)dealloc{
    [_type release];
    [_year release];
    [_area release];
    [_rating release];
    [_title release];
    [_genres release];
    [_intro release];
    [_playInfoArray release];
    [_release_area release];
    [_poster release];
    [super dealloc];
    
}

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _playInfoArray = [[NSMutableArray alloc]init];
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
    
}

+(instancetype)MovieDetailInfoWithDictionary:(NSDictionary *)dic{

    return  [[self alloc]initWithDictionary:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"submovies"]) {
        NSDictionary *dic = (NSDictionary *)value;
        NSString *key = [[dic allKeys] objectAtIndex:0];

        NSArray *arr = [dic objectForKey:key];
        for (NSDictionary *info in arr) {
            MoviePlayInfo *m = [MoviePlayInfo moviePlayInfoWithDictionary:info];
            [_playInfoArray addObject:m];
        }
    }
   
    
}

@end
