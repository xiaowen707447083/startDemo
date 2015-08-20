//
//  LOAudioStreamer.h
//  LOAudioStreamer
//
//  Created by 吴艳磊 on 15/6/3.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LOAudioStreamer;

@protocol LOAudioStreamerDelegate <NSObject>

@optional
- (void)audioStramer:(LOAudioStreamer *)stramer didPlayingWithProgress:(float)progress;

- (void)audioStramerDidFinishPlaying:(LOAudioStreamer *)streamer;

@end


@interface LOAudioStreamer : NSObject

@property (nonatomic, assign) float volume;// 播放器的音量

@property (nonatomic, assign) id<LOAudioStreamerDelegate> delegate;

@property (nonatomic, assign) float totalTime;


// 单利方法
+ (instancetype)sharedStreamer;

// 播放、暂停、停止
- (void)play;

- (void)pause;

- (void)stop;

// 设置音频的URL
- (void)setAudioMetadataWithURL:(NSString *)urlString;

- (void)seekToTime:(float)time;// 跳转到指定的时间播放

- (BOOL)isPlaying;// 判断是否正在播放
- (BOOL)isPrepared;// 判断是否准备完成
- (BOOL)isPlayingCurrentAudioWithURL:(NSString *)urlString;// 判断是否正在播放指定的URL


@end
