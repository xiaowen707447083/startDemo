//
//  LOMoviePlayerView.m
//  VideoText
//
//  Created by lanou3g on 15/6/9.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "LOMoviePlayerView.h"
#import <MediaPlayer/MediaPlayer.h>


@interface LOMoviePlayerView ()

@property(nonatomic,retain)MPMoviePlayerViewController *moviePlayer;




@end

@implementation LOMoviePlayerView

-(instancetype)initWithFrame:(CGRect)frame moviewURL:(NSString *)url
{
    if (self = [super initWithFrame:frame]) {
        self = [[LOMoviePlayerView alloc]init];
        self.moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:url]];
        _moviePlayer.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        _moviePlayer.view.backgroundColor = [UIColor redColor];
        // [self setMovieURL:[NSURL URLWithString:url]];
        [self addSubview:_moviePlayer.view];
        
        
    }
    
    return self;
    
}


//视频的播放与暂停
-(void)player
{
    [_moviePlayer.moviePlayer play];
    
}

-(void)pause
{
    [_moviePlayer.moviePlayer pause];
}

//视频的切换
-(void)setMovieURL:(NSURL *)url
{

    
    _moviePlayer.moviePlayer.contentURL = url;
    
}

//全屏幕显示
-(void)mainScreenMovie:(BOOL)bools
{
    UIApplication *application = (UIApplication *)[UIApplication sharedApplication].delegate;
    [application  setStatusBarOrientation:  UIInterfaceOrientationLandscapeRight  animated:NO];
    _moviePlayer.view.frame = self.frame;
}

//播放进度的控制
-(void)seekToTime:(NSInteger)time
{
    
    
}


@end
