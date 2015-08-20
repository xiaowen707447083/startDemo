//
//  LOMoviePlayerView.h
//  VideoText
//
//  Created by lanou3g on 15/6/9.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOMoviePlayerView : UIView
-(instancetype)initWithFrame:(CGRect)frame moviewURL:(NSString *)url;

//视频的播放与暂停
-(void)player;

-(void)pause;

//视频的切换
-(void)setMovieURL:(NSURL *)url;

//全屏幕显示
-(void)mainScreenMovie:(BOOL)bools;

//播放进度的控制
-(void)seekToTime:(NSInteger)time;

@end
