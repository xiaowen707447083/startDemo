//
//  UIButton+MyButton.m
//  NewGWPhone
//
//  Created by 8107 on 14-9-28.
//  Copyright (c) 2014年 梁宇辉. All rights reserved.
//

#import "UIButton+MyButton.h"

@implementation UIButton (MyButton)
+(UIButton*)buttonWithFrame:(CGRect)frame andType:(UIButtonType)type andTitle:(NSString*)title andBackGroundImage:(NSString*)image{
    UIButton*button=[UIButton buttonWithType:type];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
       // [_login_btn setBackgroundColor:COLOR(250, 133, 52)];
    return button;
}
@end
