//
//  HomeSearchViewController.m
//  AFNetworking+Pod
//
//  Created by shenba on 16/4/14.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "MySearchBar.h"
#import "MyUILabel.h"
#import "UIView+SDAutoLayout.h"
#import "HomeSearchViewController.h"
#import "MyUITapGestureRecognizer.h"

@interface HomeSearchViewController ()<MySearchBarDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)MySearchBar *mySearchBar;

@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    
    _mySearchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(40,0, self.view.frame.size.width -200, 30)];
    _mySearchBar.searchTextField.textColor = [UIColor grayColor];
    _mySearchBar.searchTextField.font = [UIFont systemFontOfSize:15];
    _mySearchBar.searchTextField.placeholder = _placeholder;
    _mySearchBar.myDelegate = self;
    _mySearchBar.isClick = YES;
    self.navigationItem.titleView = _mySearchBar;

    //右边菜单
    
    
    
    [self createMyView];
}

-(void)createMyView{
    
    UILabel *nearLable = [[UILabel alloc] init];
    [self.view addSubview:nearLable];
    nearLable.text = @"最近搜索";
    nearLable.textColor = [UIColor redColor];
    
//    nearLable.sd_layout
//    .topSpaceToView(self.view,74)
//    .leftSpaceToView(self.view,10)
//    .widthIs(100)
//    .heightIs(20);
    nearLable.frame = CGRectMake(10, 74, 100, 20);
    
    //删除按钮的拜访
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageWidth = nearLable.frame.size.height;
    imageView.frame = CGRectMake(self.view.frame.size.width-10-imageWidth,nearLable.frame.origin.y , imageWidth, imageWidth);
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor redColor];
    imageView.userInteractionEnabled = YES;
    
    MyUITapGestureRecognizer *tap1 = [[MyUITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLableCrash)];
    //设置点击次数
    tap1.numberOfTapsRequired = 1;//主要
    //将这个手势添加到图片上
    [imageView addGestureRecognizer:tap1];
    
    
    NSArray *arr = @[@{@"name":@"测的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"1"}];
    //记住上一行最后一个元素
    
    UIEdgeInsets insets = {5, 5, 5, 5};
    UIView *befaultLable = [self addCustemView:nearLable arr:arr insets:insets font:15];//前一个lable

    
    //最后一个元素就是befaultLable
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, befaultLable.frame.size.height+befaultLable.frame.origin.y+10, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lineView];
    
    UILabel *hotLable = [[UILabel alloc] init];
    [self.view addSubview:hotLable];
    hotLable.text = @"热门搜索";
    hotLable.textColor = [UIColor redColor];
    hotLable.frame = CGRectMake(10, lineView.frame.origin.y+0.5+10, 100, 20);
    
    //热门部分
    UIEdgeInsets insets1 = {4, 4, 4, 4};
    UIView *resultView = [self addCustemView:hotLable arr:arr insets:insets1 font:14];
    
    
    
}

//前一个view输入,返回最后一个view
-(UIView *)addCustemView:(UIView *)befaultLine_LastLable arr:(NSArray *)arr insets:(UIEdgeInsets)insets font:(CGFloat)font{
    UIView *befaultLable = nil;
    for (NSDictionary *tempDic in arr) {
        MyUILabel *tempLable = [[MyUILabel alloc] init];
        tempLable.userInteractionEnabled = YES;
       
        
        
        tempLable.font  = [UIFont systemFontOfSize:font];
        tempLable.insets = insets;
        [self.view addSubview:tempLable];
        tempLable.text = tempDic[@"name"];
        UIColor *color;
        if ([tempDic[@"color"] isEqualToString:@"1"]) {
            color = [UIColor blueColor];
        }else{
            color = [UIColor greenColor];
        }
        tempLable.textColor = color;
        tempLable.layer.cornerRadius = 4;
        tempLable.layer.masksToBounds = YES;
        tempLable.layer.borderColor = color.CGColor;
        tempLable.layer.borderWidth = 1;
        
        //添加元素
        if (befaultLable == nil) {
            
            tempLable.frame = CGRectMake(10, befaultLine_LastLable.frame.size.height+befaultLine_LastLable.frame.origin.y+10, 0, 0);
            [tempLable sizeToFit];
            
            
            
        }else{
            
            tempLable.frame = CGRectMake(befaultLable.frame.size.width+befaultLable.frame.origin.x+10, befaultLable.origin.y, 0, 0);
            [tempLable sizeToFit];
            
        }
        
        NSLog(@"%f",tempLable.frame.size.width+tempLable.frame.origin.x+10);
        //判断是否需要换行(额外加上左右的内边距)
        if ((tempLable.frame.size.width+tempLable.frame.origin.x+insets.left+insets.right+10) > self.view.frame.size.width) {
            //换行处理
            befaultLine_LastLable = befaultLable;

            
            tempLable.frame = CGRectMake(10, befaultLine_LastLable.frame.size.height+befaultLine_LastLable.frame.origin.y+10, 0, 0);
            [tempLable sizeToFit];
        }
        
        //(结果数据,宽加上左右内边距,高加上上下内边距)
        tempLable.frame = CGRectMake(tempLable.frame.origin.x, tempLable.frame.origin.y, tempLable.frame.size.width+insets.left+insets.right, tempLable.frame.size.height+insets.top+insets.bottom);
        
        befaultLable = tempLable;
        
        //添加点击事件
        MyUITapGestureRecognizer *tap1 = [[MyUITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLable:)];
        //设置点击次数
        tap1.numberOfTapsRequired = 1;//主要
        tap1.myTagStr = tempLable.text;
        //将这个手势添加到图片上
        [tempLable addGestureRecognizer:tap1];
        
    }
    return befaultLable;
}


-(void)clickLableCrash{
    NSLog(@"你点击了删除图标");
}

-(void)clickLable:(MyUITapGestureRecognizer *)myTap{
    NSLog(@"你点击了%@",myTap.myTagStr);
}


#pragma -mark -----------------mysearchbar delegate --------------
-(void)searchText:(NSString *)text{
    NSLog(@"触发首页搜索选项");
}
-(void)searchAnSuccess{
    
    NSLog(@"首页提示搜索不能为空");
    UIAlertView *arr = [[UIAlertView alloc] initWithTitle:nil message:@"搜索不能为空" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    [arr show];
}

#pragma -mark ------------uialertview delegate----------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

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
