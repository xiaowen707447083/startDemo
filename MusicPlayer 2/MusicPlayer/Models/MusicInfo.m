//
//  MusicInfo.m
//  MusicPlayer
//
//  Created by Duke on 15/6/1.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "MusicInfo.h"

@implementation MusicInfo

+ (instancetype)musicInfoWithDictionary:(NSDictionary *)dict {
    MusicInfo *music = [[MusicInfo alloc] init];
    music.album = dict[@"album"];
    music.singer = dict[@"singer"];
    music.blurPicUrl = dict[@"blurPicUrl"];
    music.mp3Url = dict[@"mp3Url"];
    music.artists = dict[@"artists_name"];
    music.identifier = dict[@"id"];
    music.duration = dict[@"duration"];
    music.lyric = dict[@"lyric"];
    music.name = dict[@"name"];
    music.thumbUrl = dict[@"picUrl"];
    music.coverUrl = dict[@"picUrl"];
    NSLog(@"dict ===== %@", dict);
    return [music autorelease];
}

- (void)dealloc {
    [_album release];
    [_mp3Url release];
    [_name release];
    [_singer release];
    [_thumbUrl release];
    [_coverUrl release];
    [_blurPicUrl release];
    [_duration release];
    [_identifier release];
    [_artists release];
    [super dealloc];
}




@end
