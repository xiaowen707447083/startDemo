//
//  UILabel+MyLabel.h
//  LanouCProject
//
//  Created by lanou on 15/8/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MyLabel)

//声明计算label高度的方法
+(CGFloat)getLabelHeight:(CGFloat)wordSize labelWidth:(CGFloat)labelWidth content:(NSString *)content;


@end
