//
//  MovieBaseInfo.m
//  VideoText
//
//  Created by 吴艳磊 on 15/6/8.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "MovieBaseInfo.h"

@implementation MovieBaseInfo

-(void)dealloc{
    [_ID release];
    [_img release];
    [_title release];
    [super dealloc];
}



-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }else if ([key isEqualToString:@"poster"]) {
        self.img = value;
    }
}

#pragma mark 进行编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.img  forKey:@"img"];
    
}

#pragma mark 反编码
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    return self;
    
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{

    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return  self;
}


+ (instancetype)movieBaseInfoWithDictionary:(NSDictionary *)dic{
    
    return  [[[MovieBaseInfo alloc]initWithDictionary:dic]autorelease];
}



@end
