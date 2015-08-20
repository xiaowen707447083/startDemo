//
//  MovieDetailInfo.h
//  VideoText
//
//  Created by 吴艳磊 on 15/6/8.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoviePlayInfo.h"

@interface MovieDetailInfo : NSObject

@property(nonatomic,retain)NSString *type;
@property(nonatomic,retain)NSString *year;
@property(nonatomic,retain)NSString *area;//地区
@property(nonatomic,retain)NSString *rating;//评分
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *genres;//类型
@property(nonatomic,retain)NSString *intro;//介绍
@property(nonatomic,retain)NSString *release_area;//发布地区
@property(nonatomic,retain)NSString *poster;
@property(nonatomic,retain)NSString *actor;
@property(nonatomic,retain)NSString *director;
@property(nonatomic,retain)NSMutableArray *playInfoArray;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

+ (instancetype)MovieDetailInfoWithDictionary:(NSDictionary *)dic;



@end
