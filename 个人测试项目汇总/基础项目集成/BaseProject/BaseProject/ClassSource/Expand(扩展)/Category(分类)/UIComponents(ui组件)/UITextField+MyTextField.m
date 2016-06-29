//
//  UITextField+MyTextField.m
//  NewGWPhone
//
//  Created by 8107 on 14-9-28.
//  Copyright (c) 2014年 梁宇辉. All rights reserved.
//

#import "UITextField+MyTextField.h"

@implementation UITextField (MyTextField)

+(UITextField*)textFieldWithFrame:(CGRect)frame andPlaceHolder:(NSString*)placeText{
    UITextField*text_fi=[[UITextField alloc]initWithFrame:frame];
    [text_fi setBackgroundColor:TextFiled_Color];
    [text_fi setPlaceholder:placeText];
    [text_fi setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [text_fi setFont:[UIFont systemFontOfSize:15]];
    [text_fi setBorderStyle:UITextBorderStyleRoundedRect];
    return text_fi;
}

+(UITextField*)commonTextFieldWithFrame:(CGRect)frame andPlaceHolder:(NSString*)placeText{
    UITextField*text_fi=[[UITextField alloc]initWithFrame:frame];
    [text_fi setBackgroundColor:[UIColor clearColor]];
    [text_fi setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [text_fi setPlaceholder:placeText];
    [text_fi setFont:[UIFont systemFontOfSize:15]];
    return text_fi;
}

-(void)setYHPlaceholder:(NSString*)placeHolder{
    [self setPlaceholder:placeHolder];
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setFont:[UIFont systemFontOfSize:15]];
}
@end
