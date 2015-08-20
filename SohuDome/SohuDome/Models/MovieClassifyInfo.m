//
//  MovieChannel.m
//  VideoText
//
//  Created by 吴艳磊 on 15/6/8.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "MovieClassifyInfo.h"

@implementation MovieClassifyInfo

-(void)dealloc{
    [_apiurl release];
    [_icon release];
    [_icon_url release];
    [_title release];
    [super dealloc];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}


+ (instancetype)movieClassifyInfoWithDictionary:(NSDictionary *)dic{

    return [[[MovieClassifyInfo alloc]initWithDictionary:dic]autorelease];
}


@end
