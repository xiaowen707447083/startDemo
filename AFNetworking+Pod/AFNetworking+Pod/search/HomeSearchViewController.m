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
@property(nonatomic,strong)UIScrollView *scrollerView;

@property(nonatomic,strong)UILabel *nearLable;  //最近搜索
@property(nonatomic,strong)UIImageView *imageView;  //删除图标
@property(nonatomic,strong)UIView *lineView;  //横线
@property(nonatomic,strong)UILabel *hotLable;//热门搜索

@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    _scrollerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_scrollerView];
    
    _mySearchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(40,0, self.view.frame.size.width -120, 30)];
    _mySearchBar.searchTextField.textColor = [UIColor grayColor];
    _mySearchBar.searchTextField.font = [UIFont systemFontOfSize:15];
    _mySearchBar.searchTextField.placeholder = _placeholder;
    _mySearchBar.myDelegate = self;
    _mySearchBar.isClick = YES;
    self.navigationItem.titleView = _mySearchBar;

    //右边菜单
    [self initNav];
    
    
    [self createMyView];
}

//配置导航栏
- (void)initNav {
    
    //激活按钮
    UIButton *rightButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightButton.titleLabel setTextAlignment:NSTextAlignmentRight];
//    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, isGreaterOrEqualIOS7 ? 0 : 10)];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30,0,0)];
    [rightButton setTitle:@"搜索" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchWithRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
    // 导航栏右侧添加分享按钮
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

-(void)dealloc{
    
    if (_scrollerView!=nil) {
        _scrollerView.delegate = nil;
    }
    _scrollerView = nil;//防止崩溃
}

-(void)createMyView{
    
    _nearLable = [[UILabel alloc] init];
    [_scrollerView addSubview:_nearLable];
    _nearLable.text = @"最近搜索";
    _nearLable.textColor = [UIColor redColor];
    
//    nearLable.sd_layout
//    .topSpaceToView(self.view,74)
//    .leftSpaceToView(self.view,10)
//    .widthIs(100)
//    .heightIs(20);
    _nearLable.frame = CGRectMake(10, 10, 100, 20);
    
    //删除按钮的拜访
    _imageView = [[UIImageView alloc] init];
    CGFloat imageWidth = _nearLable.frame.size.height;
    _imageView.frame = CGRectMake(self.view.frame.size.width-10-imageWidth,_nearLable.frame.origin.y , imageWidth, imageWidth);
    [_scrollerView addSubview:_imageView];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.userInteractionEnabled = YES;
    
    MyUITapGestureRecognizer *tap1 = [[MyUITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLableCrash)];
    //设置点击次数
    tap1.numberOfTapsRequired = 1;//主要
    //将这个手势添加到图片上
    [_imageView addGestureRecognizer:tap1];
    
    
    NSArray *arr = @[@{@"name":@"测的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测的东西",@"color":@"0"},@{@"name":@"测试的东西试的东西试的东西试的东西测试的东西试的东西试的东西试的东西测试的东西试的东西试的东西试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测试的东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"0"},@{@"name":@"测东西",@"color":@"1"},@{@"name":@"测试的东西",@"color":@"1"}];
    //记住上一行最后一个元素
    
    UIEdgeInsets insets = {5, 5, 5, 5};
    UIView *befaultLable = [self addCustemView:_nearLable arr:arr insets:insets font:15 target:2];//前一个lable

    
    //最后一个元素就是befaultLable
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, befaultLable.frame.size.height+befaultLable.frame.origin.y+10, self.view.frame.size.width, 1)];
    _lineView.backgroundColor = [UIColor blueColor];
    [_scrollerView addSubview:_lineView];
    
    _hotLable = [[UILabel alloc] init];
    [_scrollerView addSubview:_hotLable];
    _hotLable.text = @"热门搜索";
    _hotLable.textColor = [UIColor redColor];
    _hotLable.frame = CGRectMake(10, _lineView.frame.origin.y+0.5+10, 100, 20);
    
    //热门部分
    UIEdgeInsets insets1 = {4, 4, 4, 4};
    UIView *resultView = [self addCustemView:_hotLable arr:arr insets:insets1 font:14 target:3];
    
    _scrollerView.contentSize = CGSizeMake(self.view.frame.size.width, resultView.frame.size.height+10+resultView.frame.origin.y);
    
}

//前一个view输入,返回最后一个view
-(UIView *)addCustemView:(UIView *)befaultLine_LastLable arr:(NSArray *)arr insets:(UIEdgeInsets)insets font:(CGFloat)font target:(int)target{
    UIView *befaultLable = nil;
    for (NSDictionary *tempDic in arr) {
        MyUILabel *tempLable = [[MyUILabel alloc] init];
        tempLable.tag = target;
        tempLable.userInteractionEnabled = YES;
       
        
        
        tempLable.font  = [UIFont systemFontOfSize:font];
        tempLable.insets = insets;
        [_scrollerView addSubview:tempLable];
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
        
//        NSLog(@"%f",tempLable.frame.size.width+tempLable.frame.origin.x+10);

        //判断是否需要换行(额外加上左右的内边距)
        if ((tempLable.frame.size.width+tempLable.frame.origin.x+insets.left+insets.right+10) > self.view.frame.size.width) {
            //换行处理
            befaultLine_LastLable = befaultLable;

            
            tempLable.frame = CGRectMake(10, befaultLine_LastLable.frame.size.height+befaultLine_LastLable.frame.origin.y+10, 0, 0);
            [tempLable sizeToFit];
        }
        
        //如果字数过多的话,对tempLable进行限制(边距也也要计算上),防止布局出错
        if (tempLable.frame.size.width >= _scrollerView.frame.size.width - 20 - (insets.left+insets.right)) {
            tempLable.frame = CGRectMake(tempLable.frame.origin.x, tempLable.frame.origin.y, _scrollerView.frame.size.width - 20 - (insets.left+insets.right), tempLable.frame.size.height);
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
    
    //递归动画逐个删除
    int targLine = 0;

    [self deleteViewFromSubView:_scrollerView withTag:1 withLineBegain:targLine];
    
    
    
}

-(void)deleteViewFromSubView:(UIView *)subView withTag:(int)tag withLineBegain:(int)begainLine{
    
    NSArray *arr = [subView subviews];
    for (UIView *tempView in arr) {
        if ([tempView isKindOfClass:[UIView class]]) {
            if (tempView.tag == 2) {

                //如果是每行的起点,行数+1
                if (tempView.frame.origin.x == 10) {
                    begainLine++;
                }
                //删除view 动画删除
                        [UIView animateWithDuration:0.01 animations:^{
                            tempView.alpha = 0.1;
                        } completion:^(BOOL finished) {
                            
//                                if (begainLine!=1) {
//                                    //坐标上移动 一个标签位置
//                                    if (tempView.frame.origin.x == 10) {
//                                        [self updateLocationView:_scrollerView height_distance:-tempView.frame.size.height-10];
//                                    }
//                                }
                                [tempView removeFromSuperview];

                                [self deleteViewFromSubView:subView withTag:tag withLineBegain:begainLine];

                        }];
                //递归回调
                return;
            }
        }
    }
    //删除最近搜索
    [_nearLable removeFromSuperview];
    [_imageView removeFromSuperview];
    //删除横线
    [_lineView removeFromSuperview];
    
    //修改热门搜索后面的view的位置
                        [UIView animateWithDuration:0.8 animations:^{
                            [self updateLocationViewAll:_scrollerView height_distance:-_hotLable.frame.origin.y+10];
                        } completion:^(BOOL finished) {
                            [self updateLocationViewAll:_scrollerView height_distance:-_hotLable.frame.origin.y+10];
                        }];
    
    //用户本地记录数据清除
   
    
}
//
//-(void)updateLocationView:(UIView *)subView height_distance:(float)distance{
//    
//    NSArray *arr = [subView subviews];
//    for (UIView *tempView in arr) {
//        if ([tempView isKindOfClass:[UIView class]]) {
//            
//            if (tempView == _nearLable||tempView == _imageView) {
//                continue;
//            }
//            
//            CGRect tempRect = tempView.frame;
//            tempRect.origin.y = tempRect.origin.y + distance;
//            
//            
////                    [UIView animateWithDuration:0.05 animations:^{
////                        tempView.frame = tempRect;
////                    } completion:^(BOOL finished) {
//                            tempView.frame = tempRect;
////                    }];
//            
//            
//        }
//        
//    }
//    
//}

-(void)updateLocationViewAll:(UIView *)subView height_distance:(float)distance{
    
    NSArray *arr = [subView subviews];
    for (UIView *tempView in arr) {
        if ([tempView isKindOfClass:[UIView class]]) {
            CGRect tempRect = tempView.frame;
            tempRect.origin.y = tempRect.origin.y + distance;
            
//            [UIView animateWithDuration:0.05 animations:^{
//                tempView.frame = tempRect;
//            } completion:^(BOOL finished) {
                tempView.frame = tempRect;
//            }];
            
        }
        
    }
    
}

-(void)clickLable:(MyUITapGestureRecognizer *)myTap{
    NSLog(@"你点击了%@",myTap.myTagStr);
}


-(void)searchWithRightMenu{
    NSLog(@"你点击了右边的搜索按钮");
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
