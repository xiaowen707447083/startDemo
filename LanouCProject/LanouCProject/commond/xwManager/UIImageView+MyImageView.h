//
//  UIImageView+MyImageView.h
//  LanouBProject
//
//  Created by lanou on 15/8/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MyImageView)

//根据view尺寸剪切图片 图片不会失真,但会被剪切
-(void)setImageSizeToFit:(UIImage *)image;


//根据比例获取新的图片
+(UIImage *)imageWithRect:(UIImage *)image width:(CGFloat)width height:(CGFloat)height;

//显示loading动画
-(void)loading;
//隐藏loading动画
-(void)cancelLoading;

@end
