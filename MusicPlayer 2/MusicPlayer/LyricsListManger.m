//
//  LyricsListManger.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/3.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "LyricsListManger.h"
#import "LyricsItem.h"

@interface LyricsListManger ()

@property (nonatomic,retain)NSArray *countArray;
@property (nonatomic,retain)NSArray *itemCount;


@end

@implementation LyricsListManger

+(instancetype)sharedManger
{
    static LyricsListManger *manger = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        
        manger = [[LyricsListManger alloc] init];
    });
   
    return manger;
    
}


//传入字符串得到数组
-(NSArray *)obtainLyricsArray:(NSString *)lyricsString
{
    NSArray *lyricsArray = [lyricsString componentsSeparatedByString:@"\n"];
    self.countArray = lyricsArray;
    return lyricsArray;
    
}
//获取全部的lyricitrm
-(NSArray *)obtainLyricsItemArray
{
    NSMutableArray *ItemArray = [NSMutableArray array];
    for (NSString *string in self.countArray) {
        if ([string length] == 0) {
            LyricsItem *item = [[LyricsItem alloc] createLyricsItemTime:400 lyricsString:@""];
            [ItemArray addObject:item];
            
        }else{
            NSArray *array = [string componentsSeparatedByString:@"]"];
            NSArray *timeArray = [array[0] componentsSeparatedByString:@":"];
            double sconds = (double)[[timeArray[0] substringFromIndex:1] intValue]*60 +[timeArray[1] doubleValue];
            LyricsItem *item = [[LyricsItem alloc] createLyricsItemTime:sconds lyricsString:array[1]];
            [ItemArray addObject:item];
            
        }
        
        
    }
    self.itemCount = (NSArray *)ItemArray;
    
    return self.itemCount;
}
//根据指定时间获取歌词
-(NSString *)obtainLyricsString:(double)time
{
    NSArray *array = [self obtainLyricsItemArray];
    for (int i = 0; i< [array count]; i++) {
        LyricsItem *item = array[i];
        LyricsItem *items = array[i-1];
        if (time < item.time) {
            return items.lyricsString;
            
        }
    }
    
    return 0;
}
//根据时间获取下标
-(int)obtainLyricsIndext:(double)time
{
    NSArray *array = [self obtainLyricsItemArray];
    for (int i = 0; i< [array count]; i++) {
        LyricsItem *item = array[i];
        if (time == 0 ) {
            return 0;
        }else if (time < item.time) {
            return i-1;
        }
    }
    
    return 0;
    
}

//根据下标获取item
-(LyricsItem *)obtainIndextItem:(int)indext
{
    return self.itemCount[indext];
    
}


@end
