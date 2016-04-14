//
//  MyUILabel.m
//  AFNetworking+Pod
//
//  Created by shenba on 16/4/14.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "MyUILabel.h"

@implementation MyUILabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawTextInRect:(CGRect)rect {
//    UIEdgeInsets insets = {5, 5, 5, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _insets)];
}


@end
