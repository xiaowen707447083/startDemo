//
//  MovieChannel.h
//  VideoText
//
//  Created by 吴艳磊 on 15/6/8.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieClassifyInfo : NSObject

@property(nonatomic,retain)NSString *apiurl;
@property(nonatomic,retain)NSString *icon;
@property(nonatomic,retain)NSString *icon_url;
@property(nonatomic,retain)NSString *title;

-(instancetype)initWithDictionary:(NSDictionary *)dic;


+ (instancetype)movieClassifyInfoWithDictionary:(NSDictionary *)dic;

@end
