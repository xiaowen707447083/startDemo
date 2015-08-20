//
//  MusicInfo.h
//  MusicPlayer
//
//  Created by Duke on 15/6/1.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicInfo : NSObject

@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *mp3Url;
@property (nonatomic, retain) NSString *thumbUrl;
@property (nonatomic, retain) NSString *coverUrl;
@property (nonatomic, retain) NSString *blurPicUrl;
@property (nonatomic, retain) NSString *lyric;
@property (nonatomic, retain) NSString *album;
@property (nonatomic, retain) NSString *singer;
@property (nonatomic, retain) NSNumber *duration;
@property (nonatomic, retain) NSString *artists;

+ (instancetype)musicInfoWithDictionary:(NSDictionary *)dict;

@end
