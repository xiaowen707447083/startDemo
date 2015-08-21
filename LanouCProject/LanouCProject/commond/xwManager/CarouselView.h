//
//  CarouselView.h
//  lanou_轮播动画
//
//  Created by lanou on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>


//代理传值
@protocol CarouserlViewDelegate <NSObject>
//当前点击的是第几个view,目前值添加到会循环播放的view
-(void)clickIndexView:(NSInteger)index;

@end

@interface CarouselView : UIView

//数据(图片)
@property(nonatomic,strong)NSArray *array;
//数据(文字)
@property(nonatomic,strong)NSArray *arrayText;
//代理
@property(nonatomic,weak)id<CarouserlViewDelegate>myDelegate;//这里使用weak 弱引用,不会出现互相引用问题，也不会出现crash(引用被释放)问. view被释放时，由于是delegate是weak属性的，所以delegate将自动被设置为空。

//加载
-(void)viewDidAppear;
//消失
-(void)viewDidDisAppear;

//上一页
-(void)goBack;
//下一页
-(void)goNext;
//选择某项
-(void)changeIndex:(NSInteger) inte;

@end
