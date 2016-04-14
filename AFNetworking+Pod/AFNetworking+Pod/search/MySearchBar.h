//
//  MySearchBar.h
//  AFNetworking+Pod
//
//  Created by shenba on 16/4/14.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MySearchBarDelegate <NSObject>

//触发点击图标部分
-(void)onclickImageLeft;
//触发点击文字部分
-(void)onclickTextFile;
//搜索触发
-(void)searchText:(NSString *)text;
//搜索条件不成立触发
-(void)searchAnSuccess;

@end


@interface MySearchBar : UIView

@property(strong,nonatomic)UITextField *searchTextField;//搜索框
@property(strong,nonatomic)UIImageView *imageView;//搜索图片
@property(nonatomic,weak)id<MySearchBarDelegate> myDelegate;

//输入框是否可以点击
@property(assign,nonatomic)Boolean isClick;

//外部调用搜索选项
-(void)searchText:(NSString *)text;


@end
