//
//  LOMovieView.m
//  VideoPlayer
//
//  Created by 吴艳磊 on 15/6/9.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "LOMovieView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"

#define kPlayerButtonWidth 30
#define kPlyerButtonHeight 30
#define kSpace 5

@interface LOMovieView ()
{
    MPMoviePlayerController* _player;
    UISlider* _slider;
    NSTimer* _timer;
    UIView* _controllView;
    UIButton* _playOrPauseBtn;
    UIButton* _fullScreenBtn;
    UILabel* _timeLabel;
    CGRect _myViewFrame;
    UIImageView* _alphaImageView;
    UIView* _hidderView;
    UIButton* _backButton;
    UILabel* _titleLabel;
    UIActivityIndicatorView* _juhuaView;
}

@property (nonatomic, assign) BOOL isFullScreen;

@end

@implementation LOMovieView

- (instancetype)initWithFrame:(CGRect)frame movieURL:(NSString *)urlString
{
    self = [super initWithFrame:frame];
    if (self) {
        _myViewFrame = frame;
        _player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:urlString]];
        [self addSubview:_player.view];
        
        _player.controlStyle = MPMovieControlStyleNone;
        [_player play];

        _controllView = [[UIView alloc] init];
        _controllView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        
        _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playOrPauseBtn addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"iconfont-player-play"] forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"iconfont-zanting"] forState:UIControlStateSelected];
        _playOrPauseBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_controllView addSubview:_playOrPauseBtn];
        
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn addTarget:self action:@selector(fullScreenBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"iconfont-quanping-2"] forState:UIControlStateNormal];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"iconfont-tubiao1shouqiquanping"] forState:UIControlStateSelected];
        _fullScreenBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_controllView addSubview:_fullScreenBtn];
        
        _slider = [[UISlider alloc] init];
        [_slider addTarget:self action:@selector(sliderChangeProgress:) forControlEvents:UIControlEventValueChanged];
        _slider.maximumValue = _player.duration;
        _slider.minimumValue = 0;
        [_controllView addSubview:_slider];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"00:00";
        _timeLabel.textColor = [UIColor whiteColor] ;
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        _alphaImageView = [[UIImageView alloc] initWithFrame:frame];
        _alphaImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_alphaImageView];
        
        [_controllView addSubview:_timeLabel];
        [self addSubview:_controllView];
        
        _hidderView = [[UIView alloc] init];
        _hidderView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        [self addSubview:_hidderView];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateNormal];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_hidderView addSubview:_backButton];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_hidderView addSubview:_titleLabel];
        [self portraitLayout];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeControllerHidden) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoadStatus) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(controllerViewHidden)];
        [_alphaImageView addGestureRecognizer:tap];
        _alphaImageView.userInteractionEnabled = YES;
        _controllView.hidden = NO;
        _hidderView.hidden = NO;
        
    }
    return self;
}

- (void)playOrPause:(UIButton*)sender
{
    if (sender.selected) {
        [_player pause];
        sender.selected = NO;
        _timer = nil;
    } else {
        [_player play];
        sender.selected = YES;
        [self creatTimer];
    }
}

- (void)fullScreenBtn:(UIButton*)sender
{

    [UIView animateWithDuration:0.3 animations:^{
        if (!_isFullScreen) {
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.frame = self.superview.frame;
            _isFullScreen = YES;
            _fullScreenBtn.selected = YES;
            if ([self.delegate respondsToSelector:@selector(movieViewWillFullScreen)]) {
                [self.delegate movieViewWillFullScreen];
            }
        } else {
            self.transform = CGAffineTransformMakeRotation(0);
            self.frame = _myViewFrame;
            _isFullScreen = NO;
            _fullScreenBtn.selected = NO;
            if ([self.delegate respondsToSelector:@selector(movieViewWillCancelFullScreen)]) {
                [self.delegate movieViewWillCancelFullScreen];
            }
        }
        
    }];
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)sliderChangeProgress:(UISlider*)slider
{
    _player.currentPlaybackTime = slider.value;
}

- (void)changeSliderValue:(NSTimer*)timer
{
    if (!_slider.maximumValue) {
        _slider.maximumValue = _player.duration;
    }
    _slider.value = _player.currentPlaybackTime;
    if (_player.duration) {
        if ((int)_player.duration % 3600 == 0) {
            int minute = ((int)_player.duration - (int)_player.currentPlaybackTime)/ 60;
            int second = ((int)_player.duration - (int)_player.currentPlaybackTime)% 60;
            int playMinute = (int)_player.currentPlaybackTime / 60;
            int playSecond = (int)_player.currentPlaybackTime % 60;
            _timeLabel.text = [NSString stringWithFormat:@"%02d:%02d/%02d:%02d", playMinute, playSecond, minute, second];
        } else  {
            int hour = ((int)_player.duration - (int)_player.currentPlaybackTime)/ 3600;
            int playHour = (int)_player.currentPlaybackTime / 3600;
            int minute = ((int)_player.duration - (int)_player.currentPlaybackTime - 3600 * hour)/ 60;
            int second = ((int)_player.duration - (int)_player.currentPlaybackTime - 3600 * hour)% 60;
            int playMinute = ((int)_player.currentPlaybackTime - playHour * 3600) / 60;
            int playSecond = ((int)_player.currentPlaybackTime - playHour * 3600) % 60;
            _timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d/%02d:%02d:%02d",playHour, playMinute, playSecond , hour, minute, second];

        }
    }
}


- (void)creatTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(changeSliderValue:) userInfo:nil repeats:YES];

}

- (void)landscapeLayout
{
    _player.view.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
    _controllView.frame = CGRectMake(0, self.frame.size.width - 30, self.frame.size.height , 30);
    _playOrPauseBtn.frame = CGRectMake(20, 0, 30, 30);
    _slider.frame = CGRectMake(55, 0, self.frame.size.height - 100, 30);
    _fullScreenBtn.frame = CGRectMake(self.frame.size.height - 40, 0, 30, 30);
    _timeLabel.frame = CGRectMake(self.frame.size.height - 230, 20, 175, 10);
    _alphaImageView.frame = _player.view.frame;
    _hidderView.frame = CGRectMake(0, 0, self.frame.size.height, 30);
    _backButton.frame = CGRectMake(20, 0, 30, 30);
    _titleLabel.frame = CGRectMake(55, 0, self.frame.size.height - 55, 30);
    [_backButton removeTarget:self action:@selector(backView:) forControlEvents:UIControlEventAllEvents];
    [_backButton addTarget:self action:@selector(fullScreenBtn:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)portraitLayout
{
    _player.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _alphaImageView.frame = _player.view.frame;

    _controllView.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
    _playOrPauseBtn.frame = CGRectMake(0, 0, kPlayerButtonWidth, kPlyerButtonHeight);
    _fullScreenBtn.frame = CGRectMake(self.frame.size.width - 30, 0, 30, 30);
    _slider.frame = CGRectMake(35, 0, self.frame.size.width - 70, 30);
    _timeLabel.frame = CGRectMake(self.frame.size.width - 210, 20, 175, 10);
    _hidderView.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    _backButton.frame = CGRectMake(0, 0, 30, 30);
    _titleLabel.frame = CGRectMake(30, 0, self.frame.size.width - 30, 30);
    [_backButton removeTarget:self action:@selector(fullScreenBtn:) forControlEvents:UIControlEventAllEvents];
    [_backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)backView:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(comeBackView)]) {
        [self.delegate comeBackView];
    }
}

- (void)changeControllerHidden
{
    if (_player.playbackState == 1) {
        _controllView.hidden = YES;
        _hidderView.hidden = YES;
    }
}

- (void)changeLoadStatus
{
}

- (void)controllerViewHidden
{
    if (_controllView.hidden) {
        _controllView.hidden = NO;
        _hidderView.hidden = NO;
    } else {
        _controllView.hidden = YES;
        _hidderView.hidden = YES;
    }
}
- (void)layoutSubviews
{
    if (_isFullScreen == YES) {
        [self landscapeLayout];
    } else {
        [self portraitLayout];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
