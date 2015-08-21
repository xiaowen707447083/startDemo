//
//  NSObject+YY.h
//  音频学习
//
//  Created by xiaowen on 15/8/6.
//  Copyright (c) 2015年 www.xiaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YY)

//这里的截取如果图片大于width,跟height会截取宽高的一部分
//把图片进行适配之后,重新根据坐标比例截取 x_1,x_2,y_1,y_2都是比例系数,小于1. 其中x_1,y_1为开始截取位置,x_2,y_2是宽高
+(UIImage *)imageWithRect_type:(UIImage *)image width:(CGFloat)width height:(CGFloat)height x_1:(CGFloat)x_1 x_2:(CGFloat)x_2 y_1:(CGFloat)y_1 y_2:(CGFloat)y_2;

//根据比例获取新的图片
+(UIImage *)imageWithRect:(UIImage *)image width:(CGFloat)width height:(CGFloat)height;

///返回一个圆形图片,会根据图片的比例返回圆形图片的比例,一参数:图片名 二参数:图片的边框   三参数:图片边框的颜色
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//保存到相册
+(void)saveToXiangCe:(UIImage *)img uiview:(UIView *)view;

@end
