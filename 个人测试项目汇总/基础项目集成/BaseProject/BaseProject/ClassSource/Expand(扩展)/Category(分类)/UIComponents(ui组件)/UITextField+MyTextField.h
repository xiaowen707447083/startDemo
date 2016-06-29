//
//  UITextField+MyTextField.h
//  NewGWPhone
//
//  Created by 8107 on 14-9-28.
//  Copyright (c) 2014年 梁宇辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MyTextField)
+(UITextField*)textFieldWithFrame:(CGRect)frame andPlaceHolder:(NSString*)placeText;
+(UITextField*)commonTextFieldWithFrame:(CGRect)frame andPlaceHolder:(NSString*)placeText;
-(void)setYHPlaceholder:(NSString*)placeHolder;
@end
