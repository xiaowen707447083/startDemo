//
//  HomePageViewController.m
//  MoviePlayer
//
//  Created by 吴艳磊 on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "HomePageViewController.h"
#import "DetailViewController.h"
#import "SearchViewController.h"
#import "HistoryViewController.h"
#import"HomePageCollectionCell.h"
#import "CarouselFigureReusableView.h"
#import "AFDataModelRequest.h"
#import "UIViewController+HUD.h"
#import "SohuBaseNetworkRequestPrmopt.h"
#import "DetailViewController.h"
#import "ButtonLabelViewReusableView.h"
#import "ListViewController.h"


@interface HomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
{

    NSArray *imgArray;
    UISearchBar *mySearchBar;
    UIBarButtonItem *historyItem;
    UIBarButtonItem *searchItem;
}

@property (nonatomic,retain)NSArray *dataArray;
@property (nonatomic,retain)AFDataModelRequest *request;
@property (nonatomic,retain)SohuBaseNetworkRequestPrmopt *RequestPrmopt;
@end

@implementation HomePageViewController

- (void)enterDetail{

    
    DetailViewController *detailVC = [DetailViewController new];
    [self.navigationController showViewController:detailVC sender:nil];
    
    
}

- (void)showHistory{
 
    HistoryViewController *historyVC = [HistoryViewController new];
    [self.navigationController showViewController:historyVC sender:nil];
    
    
}

- (void)showSearch{
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width -10, 44)];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    mySearchBar.placeholder = @"搜索";
    mySearchBar.delegate = self;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:mySearchBar];
     self.navigationItem.rightBarButtonItems = @[item];

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    mySearchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.rightBarButtonItems = @[historyItem,searchItem];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_request requestMovieSearchWithPara:[NSDictionary dictionaryWithObjectsAndKeys:searchBar.text,@"url",nil] success:^(NSArray *model) {
        ListViewController *listVC = [[ListViewController alloc]init];
        listVC.dataArray = model;
        [self.navigationController pushViewController:listVC animated:YES];
        self.navigationItem.rightBarButtonItems = nil;
        self.navigationItem.rightBarButtonItems = @[historyItem,searchItem];
        
    } failed:^(DataErrorType type) {
        [_RequestPrmopt dealWithErrorWithController:self withErrorNO:NET_ERROR];
    }];
   

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
       return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width/2 - 5, 200);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource =self;
    [collectionView registerClass:[HomePageCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    
    
    [collectionView registerClass:[CarouselFigureReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lunbo"];
    [collectionView registerClass:[ButtonLabelViewReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"head"];
    self.request = [[AFDataModelRequest alloc] init];
    self.RequestPrmopt = [[SohuBaseNetworkRequestPrmopt alloc] init];
    [self showHudInView:self.view hint:@"正在加载.."];
    [_request requestMovieBaseInfoWithPara:nil success:^(NSArray *model) {
        _dataArray = (NSArray *)model;
        [collectionView reloadData];
        
    } failed:^(DataErrorType type) {
        [_RequestPrmopt dealWithErrorWithController:self withErrorNO:type];
    }];

   
    [_request requestCarouselFigureViewImage:nil success:^(NSArray *imageArray)
    {
        
        imgArray = imageArray;
       [collectionView reloadData];
        
        
    } failed:^(DataErrorType type) {
       [_RequestPrmopt dealWithErrorWithController:self withErrorNO:type];
        
    }];

    self.view.backgroundColor = [UIColor whiteColor];
 
    historyItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showHistory)];
    
    
    searchItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearch)];

    self.navigationItem.rightBarButtonItems = @[historyItem,searchItem];
       
    
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataArray count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 4;
   
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomePageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.baseInfo = _dataArray[indexPath.section][indexPath.row];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    MovieBaseInfo *info = self.dataArray[indexPath.section][indexPath.row];
//    NSMutableArray *resArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"key"]];
//    
//    int count = 0;
//    for (int a = 0; a<[resArray count]; a++) {
//        NSKeyedUnarchiver *unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:resArray[a]];
//        MovieBaseInfo *ins = [unarch decodeObjectForKey:@"info"];
//        if (ins.title == info.title) {
//            break;
//        }else
//        {
//            ++count;
//        }
//        
//    }
//    if (count == [resArray count]) {
//        NSMutableData *mutableData = [NSMutableData data];
//        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
//        [archiver encodeObject:info forKey:@"info"];
//        [archiver finishEncoding];
//        [resArray addObject:archiver];
//        [[NSUserDefaults standardUserDefaults] setObject:resArray forKey:@"key"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
 
    detail.ID = info.ID;
    [self.navigationController pushViewController:detail animated:YES];

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(collectionView.frame.size.width,200);

    }else
    {
        return CGSizeMake(collectionView.frame.size.width, 40);
    }
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
            CarouselFigureReusableView *cfView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lunbo" forIndexPath:indexPath];
            if ([imgArray count] != 0) {
                 [cfView setImagee:imgArray];
            }
        
        [cfView settilte:[self.dataArray[0] lastObject]];
         cfView.myBlock = ^(int index){
             NSLog(@"%lu",(unsigned long)index);
             DetailViewController *detail = [[DetailViewController alloc] init];
             MovieBaseInfo *info = imgArray[index];
             detail.ID = info.ID;
             [self.navigationController pushViewController:detail animated:YES];
             
                
            };
        cfView.block= ^(NSString *string)
        {
            ListViewController *listView = [[ListViewController alloc] init];
            listView.dataArray = _dataArray[0];
            [self.navigationController pushViewController:listView animated:YES];
        };
            
            return cfView;
            

        
    }else
    {
        ButtonLabelViewReusableView *buttonView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        buttonView.buttonView.button.tag = 100*(indexPath.section+1);
        [buttonView setTiltle:[self.dataArray[indexPath.section] lastObject] ];
        buttonView.tblock = ^(int indext)
        {
            
            ListViewController *listView = [[ListViewController alloc] init];
            listView.dataArray = _dataArray[indext];
            [self.navigationController pushViewController:listView animated:YES];
            
        };
        return buttonView;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    
    
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
