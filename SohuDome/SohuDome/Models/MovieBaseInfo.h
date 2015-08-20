//
//  MovieBaseInfo.h
//  VideoText
//
//  Created by 吴艳磊 on 15/6/8.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieBaseInfo : NSObject<NSCoding>

@property(nonatomic,retain)NSString *ID;
@property(nonatomic,retain)NSString *img;
@property(nonatomic,retain)NSString *title;


- (instancetype)initWithDictionary:(NSDictionary *)dic;

+ (instancetype)movieBaseInfoWithDictionary:(NSDictionary *)dic;

@end
