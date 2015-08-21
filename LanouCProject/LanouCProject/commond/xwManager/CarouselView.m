//
//  CarouselView.m
//  lanou_轮播动画
//
//  Created by lanou on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CarouselView.h"

@interface CarouselView()<UIScrollViewDelegate>

@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)UILabel *textLabel;
@property(nonatomic,assign)NSInteger curPage;
@property(nonatomic,retain)NSMutableArray *curArray;

@property(nonatomic,assign)CGFloat width;//宽
@property(nonatomic,assign)CGFloat height;//高




@end

@implementation CarouselView

- (instancetype)initWithFrame:(CGRect)frame
{
    //设置宽高
    _width = frame.size.width;
    _height = frame.size.height;
    
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self initWithScrollView];
        [self initWithPageController];
        [self initWithTextLabel];
    }
    return self;
}

//初始化
-(void)initWithScrollView
{
    //
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    //设置分页效果
    _scrollView.pagingEnabled = YES;
    //设置滑动区域
    _scrollView.contentSize = CGSizeMake(_width*3, 0);//0默认图片的高度
    //隐藏滑动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;//设置代理人
    //设置当前显示的位置
    _scrollView.contentOffset = CGPointMake(_width, 0);//第二张图片的位置
    self.curArray = [NSMutableArray arrayWithCapacity:3];//autolease
    for (int a = 0; a < 3; a++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_width * a, 0, _width, _height)];

        [_scrollView addSubview:imageView];
    }
    
    //1 点击 ***********************************************
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    //设置点击次数
    tap.numberOfTapsRequired = 1;//主要
    //将这个手势添加到_scrollView上
    [_scrollView addGestureRecognizer:tap];
    
    [self addSubview:_scrollView];
    
}

//点击方法
-(void)click:(UIScrollView *)scView
{
    NSLog(@"当前点击的view为:%ld",_curPage);
    [self.myDelegate clickIndexView:_curPage];
}

//初始化
-(void)initWithPageController
{
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_width - 80, _height - 30, 70, 30)];
//    [self addSubview:_pageControl];
    
}

//初始化
-(void)initWithTextLabel
{
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _height - 40, _width - 100, 50)];
    _textLabel.textColor = [UIColor redColor];
    
    //隐藏
//    [self addSubview:_textLabel];
    
}


-(void)setArray:(NSArray *)array
{
    _array = array;
    
    //我的数据等于传递来的数据源
    _pageControl.numberOfPages = _array.count;
    
    //设置pageController当前显示的索引
    _pageControl.currentPage = 0;
    [self updateCurViewWithPage:0];
  
    
}


-(void)setArrayText:(NSArray *)arrayText
{
    _arrayText = arrayText;
    if (_arrayText != nil) {
        _textLabel.text = _arrayText[0];
    }
}


//获取索引
-(NSInteger)updateCurgage:(NSInteger)page
{
    NSInteger count = _array.count;
    return (count + page) % count;//小算法计算
}


//替换数据源
-(void)updateCurViewWithPage:(NSInteger)page
{
    //上一页
    NSInteger pre = [self updateCurgage:page - 1];
    _curPage = [self updateCurgage:page];
    //下一页
    NSInteger last = [self updateCurgage:page + 1];
    
    //移除数组里面的元素,添加当前显示的三张图
    [_curArray removeAllObjects];
    [_curArray addObject:_array[pre]];
    [_curArray addObject:_array[_curPage]];
    [_curArray addObject:_array[last]];
    
    //获取scrollerView的子视图
    NSArray *arrays = [_scrollView subviews];
    for ( int i = 0; i < [arrays count]; i++) {//只有3张图片
        UIImageView *tempImageView = arrays[i];
        tempImageView.image = [UIImage imageNamed:_curArray[i]];
        //textlabel赋值
        if (i == 1) {
            if (_arrayText != nil) {
                _textLabel.text = _arrayText[_curPage];
            }
            
        }
    }
    
    //设置当前显示的位置
    _scrollView.contentOffset = CGPointMake(_width, 0);
    
//    //设置pageController当前显示的索引
//    _pageControl.currentPage = _curPage;
    
}

//每次滑动都有调用该方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat x = scrollView.contentOffset.x;
//    if (x >= _width *2) {//右滑动
////        NSLog(@"右滑");
//        [self updateCurViewWithPage:_curPage + 1];
//    }else if(x <= 0){
////        NSLog(@"左滑");
//        [self updateCurViewWithPage:_curPage - 1];
//    }
}

//开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

}

//上一页
-(void)goBack
{
    //带动画
//    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self updateCurViewWithPage:_curPage - 1];
}
//下一页
-(void)goNext
{
    //带动画
//    [_scrollView setContentOffset:CGPointMake(_width*2, 0) animated:YES];
    [self updateCurViewWithPage:_curPage + 1];
    //不带动画
    //    _scrollView.contentOffset = CGPointMake(_width*2, 0);
}
//选择某项
-(void)changeIndex:(NSInteger)inte{
    [self updateCurViewWithPage:inte];
}

@end
