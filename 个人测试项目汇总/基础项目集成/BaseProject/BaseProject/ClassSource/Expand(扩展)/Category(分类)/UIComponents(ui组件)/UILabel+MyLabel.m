//
//  UILabel+MyLabel.m
//  GateWangMobileToken
//
//  Created by 王选华 on 14-5-8.
//  Copyright (c) 2014年 wxh. All rights reserved.
//

#import "UILabel+MyLabel.h"

@implementation UILabel (MyLabel)

+(UILabel*)labelWithFrame:(CGRect)frame Font:(UIFont*)font textColor:(UIColor*)textColor numberOfLines:(NSInteger*)num text:(NSString *)text{
    UILabel*label=[[UILabel alloc]init];
    if (text != nil &&  ![text isEqualToString:@""]) {
        CGSize aSize;
        CGSize labelSize=CGSizeMake(frame.size.width, MAXFLOAT);
        if (IOS7) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
            aSize = [text boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        }else{
            aSize = [text sizeWithFont:font constrainedToSize:labelSize];
        }
        label.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, aSize.height);
        label.text = text;
    }
    else{
        label.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    }
    [label setFont:font];
    [label setNumberOfLines:1];
    [label setTextColor:textColor];
    [label setBackgroundColor:[UIColor clearColor]];
    label.textAlignment=NSTextAlignmentCenter;
    return label;

}

+(UILabel *)labelWithFrame:(CGRect)frame Font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = alignment;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

@end
