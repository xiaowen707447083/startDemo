//
//  LyricsItem.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/4.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "LyricsItem.h"

@implementation LyricsItem

-(LyricsItem *)createLyricsItemTime:(double)time lyricsString:(NSString *)lyricsString
{
    if (self = [super init]) {
        self.time = time;
        self.lyricsString = lyricsString;
    }
    
    return self;
    
}

@end
