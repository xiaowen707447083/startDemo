//
//  LyricsItem.h
//  MusicPlayer
//
//  Created by lanou3g on 15/6/4.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricsItem : NSObject

@property (nonatomic,assign)double time;
@property (nonatomic,retain)NSString *lyricsString;

-(LyricsItem *)createLyricsItemTime:(double)time lyricsString:(NSString *)lyricsString;

@end
