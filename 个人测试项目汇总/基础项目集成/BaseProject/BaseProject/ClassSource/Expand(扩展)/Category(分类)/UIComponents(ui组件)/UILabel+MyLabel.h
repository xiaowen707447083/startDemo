//
//  UILabel+MyLabel.h
//  GateWangMobileToken
//
//  Created by 王选华 on 14-5-8.
//  Copyright (c) 2014年 wxh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MyLabel)
+(UILabel*)labelWithFrame:(CGRect)frame Font:(UIFont*)font textColor:(UIColor*)textColor numberOfLines:(NSInteger*)num text:(NSString *)text;
+(UILabel *)labelWithFrame:(CGRect)frame Font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment;
@end
