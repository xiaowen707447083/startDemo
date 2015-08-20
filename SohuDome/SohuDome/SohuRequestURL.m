//
//  SohuRequestURL.m
//  SohuDome
//
//  Created by lanou3g on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "SohuRequestURL.h"

#define URL @"http://api.gougouvideo.com:8888/"

@implementation SohuRequestURL

+(NSString *)SohuRequestURLString:(NSString *)urlString
{
    return [NSString stringWithFormat:@"%@%@",URL,urlString];
    
}

@end
