//
//  ListViewController.m
//  MoviePlayer
//
//  Created by 吴艳磊 on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "HomePageCollectionCell.h"
#import "AFDataModelRequest.h"
#import "SohuBaseNetworkRequestPrmopt.h"
#import "UIViewController+HUD.h"

@interface ListViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain)AFDataModelRequest *request;
@property (nonatomic,retain)SohuBaseNetworkRequestPrmopt *RequestPrmopt;
@property(nonatomic,strong)UICollectionView *collectionView ;
@end


@implementation ListViewController


- (void)enterDetail{

    DetailViewController *detailVC = [DetailViewController new];
    [self showViewController:detailVC sender:nil];
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width/2 - 5, 200);
    if ([self.dataArray count] == 0) {
        [self  showHint:@"对不起，暂无数据"];
    }
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource =self;
    [_collectionView registerClass:[HomePageCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count]-1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomePageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.baseInfo = self.dataArray[indexPath.row];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    MovieBaseInfo *info = self.dataArray[indexPath.row];
    detail.ID = info.ID;
    [self.navigationController pushViewController:detail animated:YES];
                                         
    
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
