//
//  LyricsListManger.h
//  MusicPlayer
//
//  Created by lanou3g on 15/6/3.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LyricsItem.h"

@interface LyricsListManger : NSObject


+(instancetype)sharedManger;
//传入字符串得到数组
-(NSArray *)obtainLyricsArray:(NSString *)lyricsString;
//获取全部的lyricitrm
-(NSArray *)obtainLyricsItemArray;
//根据指定时间获取歌词
-(NSString *)obtainLyricsString:(double)time;
//根据时间获取下标
-(int )obtainLyricsIndext:(double)time;

//根据下标获取item
-(LyricsItem *)obtainIndextItem:(int)indext;



@end
