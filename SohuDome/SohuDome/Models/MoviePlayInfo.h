//
//  MoviePlayInfo.h
//  VideoText
//
//  Created by 吴艳磊 on 15/6/8.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviePlayInfo : NSObject

@property(nonatomic,retain)NSString *allow_download;
@property(nonatomic,retain)NSString *m3u8;
@property(nonatomic,retain)NSString *ID;
@property(nonatomic,retain)NSString *number;
@property(nonatomic,retain)NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

+ (instancetype)moviePlayInfoWithDictionary:(NSDictionary *)dic;


@end
