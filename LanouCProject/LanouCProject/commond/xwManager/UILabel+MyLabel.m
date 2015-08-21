//
//  UILabel+MyLabel.m
//  LanouCProject
//
//  Created by lanou on 15/8/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UILabel+MyLabel.h"

@implementation UILabel (MyLabel)

//实现计算lable高度的方法
+(CGFloat)getLabelHeight:(CGFloat)wordSize labelWidth:(CGFloat)labelWidth content:(NSString *)content
{
    
    //1写一个cgsize
    CGSize size = CGSizeMake(labelWidth,10000);
    //定义一个字典
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:wordSize] forKey:NSFontAttributeName];
    
    
    //计算高度
    CGRect rect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
}

@end
