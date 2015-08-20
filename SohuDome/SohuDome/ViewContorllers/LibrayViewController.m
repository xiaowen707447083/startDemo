//
//  LibrayViewController.m
//  MoviePlayer
//
//  Created by 吴艳磊 on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "LibrayViewController.h"
#import "ListViewController.h"
#import "LibiaryCollectionViewCell.h"
#import "AFDataModelRequest.h"
#import "SohuBaseNetworkRequestPrmopt.h"
#import "UIViewController+HUD.h"
#import "ListViewController.h"
#import "MovieClassifyInfo.h"
#import "LiaryDownCollectionViewCell.h"

@interface LibrayViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain)UICollectionView *collectionView;
@property (nonatomic,retain)NSMutableArray *classifyArr;
@property (nonatomic,retain)AFDataModelRequest *request ;
@property (nonatomic,retain)SohuBaseNetworkRequestPrmopt *prmopt;
@property (nonatomic,retain)NSArray *classifyArray;

@end

@implementation LibrayViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 3) / 3 , 140);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[LibiaryCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [_collectionView registerClass:[LiaryDownCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.classifyArr = [NSMutableArray array];
    
    [self showHudInView:self.view hint:@"正在加载.."];
    self.request = [[AFDataModelRequest alloc] init];
    self.prmopt = [[SohuBaseNetworkRequestPrmopt alloc] init];
    [_request requestMovieClassifyInfoWithPara:nil success:^(NSArray *model) {
        self.classifyArr = (NSMutableArray *)model;
        [_collectionView reloadData];
        
    } failed:^(DataErrorType type) {
        [_prmopt dealWithErrorWithController:self withErrorNO:type];
    }];
    
    [_request requestMovieClassifyInfoDownWithPara:nil success:^(NSArray *model) {
        self.classifyArray = (NSMutableArray *)model;
        [_collectionView reloadData];
        
    } failed:^(DataErrorType type) {
         [_prmopt dealWithErrorWithController:self withErrorNO:type];
    } ];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.classifyArr.count;
    }else{
        return self.classifyArray.count;
    }
    
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LibiaryCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
        cell.classInfo = self.classifyArr[indexPath.row];
        return cell;
    }else
    {
       LiaryDownCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.classInfo = self.classifyArray[indexPath.row];
        return cell;

        
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
   
    ListViewController *listVC = [[ListViewController alloc] init];
    MovieClassifyInfo *info;
    [self showHudInView:self.view hint:@"正在加载.."];
    if (indexPath.section == 0) {
         info = self.classifyArr[indexPath.row];
    }else
    {
        info = self.classifyArray[indexPath.row];

    }
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:info.apiurl,@"url", nil];
    [_request requestMovieBaseInfoListWithPara:dic success:^(NSArray *model) {
            listVC.dataArray = (NSArray *)model;
            [self.navigationController pushViewController:listVC animated:YES];
            
        } failed:^(DataErrorType type) {
            [_prmopt
             dealWithErrorWithController:self withErrorNO:type];
        }];

    
    
   
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake((self.view.frame.size.width)/3 -10, (self.view.frame.size.width)/3);
    }else{
        return CGSizeMake((self.view.frame.size.width) / 3-10,((self.view.frame.size.width)/3)*0.4);
    }

    
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
