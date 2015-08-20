//
//  LyricsListTableViewController.h
//  MusicPlayer
//
//  Created by lanou3g on 15/6/3.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LyricsListTableViewController;

@protocol LyricsListTableViewDelegate <NSObject>

@optional
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface LyricsListTableViewController : UITableViewController

@property(nonatomic,assign)id<LyricsListTableViewDelegate>delegate;

@end
