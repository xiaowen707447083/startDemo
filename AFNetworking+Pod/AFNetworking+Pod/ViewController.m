//
//  ViewController.m
//  AFNetworking+Pod
//
//  Created by shenba on 16/4/14.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ViewController.h"
#import "HomeSearchViewController.h"
#import "MySearchBar.h"

@interface ViewController ()<MySearchBarDelegate>

@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)MySearchBar *mySearchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    _searchBar = [[UISearchBar alloc] init];
//
//    self.navigationItem.titleView = _searchBar;
//    _searchBar.delegate = self;
//    _searchBar.placeholder = @"奶粉";
    
    
    _mySearchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(40,0, self.view.frame.size.width , 30)];
    _mySearchBar.isClick = NO;
    _mySearchBar.searchTextField.textColor = [UIColor grayColor];
    _mySearchBar.searchTextField.placeholder = @"奶粉";
    _mySearchBar.searchTextField.font = [UIFont systemFontOfSize:15];
    _mySearchBar.myDelegate = self;
    self.navigationItem.titleView = _mySearchBar;
    
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onclickLeft)];
    
    
}

-(void)onclickLeft{
    
}


#pragma -mark ---------------mysearchbar delegate-----------------
//-(void)onclickImageLeft{
//    NSLog(@"你点击了左边的图标");
//}
//-(void)onclickTextFile{
//    NSLog(@"你点击了右侧的输入框");
//    HomeSearchViewController *home = [[HomeSearchViewController alloc] init];
//    home.placeholder = _mySearchBar.searchTextField.placeholder;
//    [self.navigationController pushViewController:home animated:YES];
//    
//    
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

