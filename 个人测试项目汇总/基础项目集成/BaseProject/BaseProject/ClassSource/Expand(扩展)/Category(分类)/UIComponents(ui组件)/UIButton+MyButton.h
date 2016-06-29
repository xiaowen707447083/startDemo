//
//  UIButton+MyButton.h
//  NewGWPhone
//
//  Created by 8107 on 14-9-28.
//  Copyright (c) 2014年 梁宇辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MyButton)
+(UIButton*)buttonWithFrame:(CGRect)frame andType:(UIButtonType)type andTitle:(NSString*)title andBackGroundImage:(NSString*)image;
@end
