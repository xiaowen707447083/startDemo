//
//  MoviePlayInfo.m
//  VideoText
//
//  Created by 吴艳磊 on 15/6/8.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "MoviePlayInfo.h"

@implementation MoviePlayInfo

-(void)dealloc{

    [super dealloc];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = [NSString stringWithFormat:@"%@",value];
    }
}

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}


+ (instancetype)moviePlayInfoWithDictionary:(NSDictionary *)dic{
    
    return  [[[MoviePlayInfo alloc]initWithDictionary:dic]autorelease];
}

@end
