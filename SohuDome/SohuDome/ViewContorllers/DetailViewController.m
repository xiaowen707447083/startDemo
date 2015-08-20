//
//  DetailViewController.m
//  MoviePlayer
//
//  Created by 吴艳磊 on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "DetailViewController.h"
#import "LOMoviePlayerView.h"
#import "LOMovieView.h"
#import "SohuBaseNetworkRequestPrmopt.h"
#import "AFDataModelRequest.h"
#import "MovieDetailInfo.h"
#import "MoviePlayInfo.h"
#import "TitleTableViewCell.h"
#import "MessageTableViewCell.h"
#import "JSTableViewCell.h"

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,LOMovieViewDelegate>


@property(nonatomic,retain)AFDataModelRequest *request;
@property(nonatomic,retain)SohuBaseNetworkRequestPrmopt *prmopt;
@property(nonatomic,retain)MovieDetailInfo *info;
@property(nonatomic,retain)UITableView *tabelView;
@property(nonatomic,retain)LOMovieView *movieView;
@property(nonatomic,retain)UITableView* tableView;
@property(nonatomic,assign)BOOL isShowIntro;
@end

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.request = [[AFDataModelRequest alloc] init];
    self.prmopt = [[SohuBaseNetworkRequestPrmopt alloc] init];
    [self showHudInView:self.view hint:@"正在加载..."];
    [_request requestMovieDetailWithPara:[NSDictionary dictionaryWithObjectsAndKeys:self.ID,@"ID",nil] success:^(NSArray *model) {
        self.info = model[0];
        MoviePlayInfo *playInfo = self.info.playInfoArray[0];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, self.view.frame.size.height - 200) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:_tableView];
        
        self.movieView = [[LOMovieView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200)  movieURL:playInfo.m3u8];
        self.movieView.delegate = self;
        self.movieView.tag = 1000;
        [self.view addSubview:self.movieView];



    } failed:^(DataErrorType type) {
        [_prmopt dealWithErrorWithController:self withErrorNO:NET_ERROR];
    }];
    
    
}

- (void)initMovieViewWithUrl:(NSString*)movieUrlString
{
    [self.movieView removeFromSuperview];
    LOMovieView *movie = [[LOMovieView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200) movieURL:movieUrlString];
    movie.delegate = self;
    [self.view addSubview:movie];
}

-(void)comeBackView
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.info.playInfoArray count] > 1) {
        return 2;
    } else {
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else {
        return 1;
   }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (!cell) {
            cell = [[TitleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"titleCell"];
        }
        cell.movie = self.info;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if(indexPath.row == 1 && indexPath.section == 0){
        MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
        if (!cell) {
            cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"messageCell"];
        }
        cell.detailInfo = self.info;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else
    {
        JSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jsCell"];
        if (!cell) {
            cell = [[JSTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"jsCell"];
        }
        
        cell.myBlock = ^(int indext)
        {
            MoviePlayInfo *movieInfo = self.info.playInfoArray[(indext-100)/100];
            [self initMovieViewWithUrl:movieInfo.m3u8];
        };
        cell.count = (int)[_info.playInfoArray count];
        return cell;
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 30;
    } else if (indexPath.row == 1 && indexPath.section == 0){
        UIFont *font = [UIFont systemFontOfSize:12.0F];
        NSDictionary  *dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        CGSize actualsize = [_info.intro boundingRectWithSize:CGSizeMake(300.f, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        return self.isShowIntro? actualsize.height+80 : 80;
    } else{
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = @[indexPath];
    self.isShowIntro = !self.isShowIntro;
    [tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
    
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
