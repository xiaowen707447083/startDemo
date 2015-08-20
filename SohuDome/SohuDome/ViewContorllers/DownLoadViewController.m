//
//  DownLoadViewController.m
//  MoviePlayer
//
//  Created by 吴艳磊 on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "DownLoadViewController.h"
#import "DetailViewController.h"
@interface DownLoadViewController ()

@end

@implementation DownLoadViewController


- (void)enterDetail{
    
    
    DetailViewController *detailVC = [DetailViewController new];
    [self.navigationController showViewController:detailVC sender:nil];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor brownColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"enter" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    
    
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
