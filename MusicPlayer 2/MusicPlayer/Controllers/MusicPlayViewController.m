//
//  MusicPlayViewController.m
//  MusicPlayer
//
//  Created by Duke on 15/6/1.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "LOAudioStreamer.h"
#import "MusicInfo.h"
#import "ModelManager.h"
#import "UIImageView+WebCache.h"
#import "LyricsListManger.h"
#import "LyricsListTableViewController.h"
#import "LyricsItem.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kControlBarHeight 300
#define kControlBarOriginY (kScreenHeight - kControlBarHeight)

#define kControlBarCenterX self.view.center.x
#define kControlBarCenterY kScreenHeight - 150
#define kControlLeftCenterX kScreenWidth / 4
#define kControlRightCenterX kScreenWidth / 4 * 3

@interface MusicPlayViewController ()<LOAudioStreamerDelegate,LyricsListTableViewDelegate>


@property (nonatomic, retain) MusicInfo *currentMusic;// 当前音乐播放的模型对象

@property (nonatomic, retain) UISlider *musicProgress;

@property (nonatomic, retain) UILabel *currentLabel;
@property (nonatomic, retain) UILabel *surplusLabel;
@property (nonatomic, retain) UILabel *specialLabel;
@property (nonatomic, retain) UILabel *songLabel;
@property (nonatomic, retain) LyricsListTableViewController *lyricsTableView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UISlider *volumeSlider;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSTimer *time;
@end

@implementation MusicPlayViewController

- (void)dealloc
{
    [LOAudioStreamer sharedStreamer].delegate = nil;
    _time = nil;
    [super dealloc];
    
}

- (void)loadView
{
    self.view = [[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view.userInteractionEnabled = YES;
    //试图的模糊效果
    UIVisualEffectView *background = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    background.frame = CGRectMake(0, kControlBarOriginY, kScreenWidth, kControlBarHeight);
    [self.view addSubview:background];
    [background release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    // 获取指定下标的音乐模型对象
    self.currentMusic = [[ModelManager sharedManger] modelAtIndex:self.modelIndex];
    [[LyricsListManger sharedManger] obtainLyricsArray:self.currentMusic.lyric];
    
    // 判断当前播放的音乐和model类里面带来的URL是否是同一个 如果不是 则播放
    if (![[LOAudioStreamer sharedStreamer] isPlayingCurrentAudioWithURL:self.currentMusic.mp3Url]) {
        [[LOAudioStreamer sharedStreamer] setAudioMetadataWithURL:self.currentMusic.mp3Url];
        [[LOAudioStreamer sharedStreamer] play];
    }
    //  播放音乐
    [LOAudioStreamer sharedStreamer].delegate = self;
    // 获取背景图片的地址
    
    self.musicProgress = [[[UISlider alloc] initWithFrame:CGRectMake(0, kControlBarOriginY - 20, kScreenWidth, 40)] autorelease];
    self.musicProgress.minimumTrackTintColor = [UIColor magentaColor];
    self.musicProgress.maximumTrackTintColor = [UIColor grayColor];
    self.musicProgress.minimumValue = 0;
    [self.musicProgress setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    [self.musicProgress addTarget:self action:@selector(handlePrograssChangeAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.musicProgress];
    [self.musicProgress release];
    
    [self initMyView];
    [self relodMyView];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame = CGRectMake(0, 0, 20, 20);
    [playButton setImage:[UIImage imageNamed:@"iconfont-zanting"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"iconfont-player-play"] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(playPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    playButton.selected = ![LOAudioStreamer sharedStreamer].isPlaying;
    playButton.center = CGPointMake(kControlBarCenterX, kControlBarCenterY);
    [self.view addSubview:playButton];
    
    UIButton* nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(0, 0, 20, 20);
    [nextButton setImage:[UIImage imageNamed:@"iconfont-player-next"] forState:UIControlStateNormal];
    nextButton.center = CGPointMake(kControlRightCenterX, kControlBarCenterY);
    [nextButton addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];

    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(0, 0, 20, 20);
    [previousButton setImage:[UIImage imageNamed:@"iconfont-player-prev"] forState:UIControlStateNormal];
    previousButton.center = CGPointMake(kControlLeftCenterX, kControlBarCenterY);
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    self.volumeSlider = [self volumeSlider];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 360)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth*2, 0);
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.alwaysBounceHorizontal = NO;
    _scrollView.alwaysBounceVertical = NO;
    [self.view addSubview:_scrollView];
  
    
    self.lyricsTableView = [[LyricsListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.lyricsTableView.tableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, 360);
    self.lyricsTableView.tableView.contentInset = UIEdgeInsetsMake(200, 0, 200, 0);
    self.lyricsTableView.delegate = self;
    [self.scrollView addSubview:_lyricsTableView.tableView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250 , 250)];
    self.imageView.layer.cornerRadius = 250/2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.center = _scrollView.center;
    self.imageView.backgroundColor = [UIColor redColor];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_currentMusic.thumbUrl] placeholderImage:[UIImage imageNamed:@"thumb.png"]];
    [self.scrollView addSubview:_imageView];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(20, 30, 40, 40);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(handleDismissAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
}



- (UISlider*)volumeSlider
{
    if (!_volumeSlider) {
        self.volumeSlider = [[[UISlider alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 20)] autorelease];
        self.volumeSlider.center = CGPointMake(kControlBarCenterX, kControlBarCenterY + 50);
        [_volumeSlider setThumbImage:[UIImage imageNamed:@"volumn_slider_thumb"] forState:UIControlStateNormal];
        _volumeSlider.minimumValueImage = [[UIImage imageNamed:@"iconfont-volumemin"] imageWithAlignmentRectInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        _volumeSlider.maximumValueImage = [[UIImage imageNamed:@"iconfont-ios7volumehigh"] imageWithAlignmentRectInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [_volumeSlider addTarget:self action:@selector(handleVolumeAction:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_volumeSlider];
    }
    return _volumeSlider;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[LOAudioStreamer sharedStreamer] pause];
    [self.lyricsTableView.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
     LyricsItem *item = [[LyricsListManger sharedManger] obtainIndextItem:(int)indexPath.row];
    NSLog(@"%f",item.time);
    self.musicProgress.value = item.time;
    [[LOAudioStreamer sharedStreamer] seekToTime:item.time];
    
    
    
}

#pragma mark- delegate
- (void)audioStramer:(LOAudioStreamer *)stramer didPlayingWithProgress:(float)progress
{
    self.musicProgress.value = progress;
    int minute = (int)progress / 60;
    int second = (int)progress % 60;
    self.currentLabel.text = [NSString stringWithFormat:@"%d:%02d", minute, second];
    minute = (int)(self.musicProgress.maximumValue - progress) / 60;
    second = (int)(self.musicProgress.maximumValue - progress) % 60;
    self.surplusLabel.text = [NSString stringWithFormat:@"-%d:%02d", minute, second];
    int index = [[LyricsListManger sharedManger] obtainLyricsIndext:progress];
//    NSIndexPath *path = [[NSIndexPath alloc] initWithIndex:index ];
   
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    [self.lyricsTableView.tableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionTop];
    _imageView.transform = CGAffineTransformRotate(_imageView.transform, M_1_PI/30);
   
    
}

- (void)audioStramerDidFinishPlaying:(LOAudioStreamer *)streamer
{
    [self nextButtonClicked:nil];
}

#pragma mark- action
//滑动播放进度的控件设置音乐的播放时间
- (void)handlePrograssChangeAction:(UISlider *)sender
{
    [[LOAudioStreamer sharedStreamer] seekToTime:sender.value];
}

- (void)handleDismissAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//播放暂停按钮
- (void)playPauseAction:(UIButton *)sender
{
    if (sender.selected) {
        sender.selected = NO;
        [[LOAudioStreamer sharedStreamer] play];
    } else {
        sender.selected = YES;
        [[LOAudioStreamer sharedStreamer] pause];
        self.imageView.transform = CGAffineTransformMakeRotation(0);
       
       
    }
}

//下一曲
- (void)nextButtonClicked:(UIButton *)sender
{
    //让modelIndex自减
    if (self.modelIndex == [[ModelManager sharedManger] countOfModels] - 1) {
        self.modelIndex = 0;
    } else {
        self.modelIndex += 1;
    }
    
    self.currentMusic = [[ModelManager sharedManger] modelAtIndex:self.modelIndex];
    [[LOAudioStreamer sharedStreamer] setAudioMetadataWithURL:self.currentMusic.mp3Url];
    //加载图片和歌词
    [self relodMyView];
    
}

- (void)previousClicked:(UIButton *)sender
{
    if (self.modelIndex == 0) {
        self.modelIndex = [[ModelManager sharedManger] countOfModels] - 1;
    } else {
        self.modelIndex -= 1;
    }
    self.currentMusic = [[ModelManager sharedManger] modelAtIndex:self.modelIndex];
    [[LOAudioStreamer sharedStreamer] setAudioMetadataWithURL:self.currentMusic.mp3Url];
    [self relodMyView];

}

- (void)handleVolumeAction:(UISlider*)slider
{
    [LOAudioStreamer sharedStreamer].volume = slider.value;
}

#pragma mark- initMyView
- (void)initMyView
{
    self.currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kControlBarOriginY + 20, 100, 20)];
    self.currentLabel.text = @"0:00";
    [self.view addSubview:self.currentLabel];
    [self.currentLabel release];
    
    self.surplusLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 120, kControlBarOriginY + 20, 100, 20)];
    int second = (int)self.musicProgress.maximumValue % 60;
    int minute = (int)self.musicProgress.maximumValue / 60;
    self.surplusLabel.textAlignment = NSTextAlignmentRight;
    self.surplusLabel.text = [NSString stringWithFormat:@"-%d:%d", minute, second];
    [self.view addSubview:self.surplusLabel];
    [self.surplusLabel release];
    
    self.specialLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kControlBarOriginY + 50, kScreenWidth, 30)];
    //    self.specialLabel.text = self.currentMusic.album;
    self.specialLabel.font = [UIFont systemFontOfSize:20];
    self.specialLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.specialLabel];
    [self.specialLabel release];
    
    self.songLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kControlBarOriginY + 80, kScreenWidth, 20)];
    self.songLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.songLabel];
    [self.songLabel release];

}

- (void)relodMyView
{
    NSString *blurImageURLStr = [self.currentMusic.blurPicUrl stringByAppendingFormat:@"?param=%fy%f", [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height];
     [[LyricsListManger sharedManger] obtainLyricsArray:self.currentMusic.lyric];
    self.imageView.transform = CGAffineTransformMakeRotation(0);
    [self.lyricsTableView.tableView reloadData];
    [(UIImageView *)self.view setImageWithURL:[NSURL URLWithString:blurImageURLStr]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_currentMusic.thumbUrl] placeholderImage:[UIImage imageNamed:@"thumb.png"]];
    [self.scrollView addSubview:_imageView];
    self.specialLabel.text = self.currentMusic.album;
    self.songLabel.text = [NSString stringWithFormat:@"%@/%@", self.currentMusic.name, self.currentMusic.artists];
    self.musicProgress.maximumValue = [self.currentMusic.duration floatValue] / 1000;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
