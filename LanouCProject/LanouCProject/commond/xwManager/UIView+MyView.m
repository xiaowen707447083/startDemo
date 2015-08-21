//
//  UIView+MyView.m
//  LanouBProject
//
//  Created by lanou on 15/8/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UIView+MyView.h"
#import "MBProgressHUD.h"
#import "ConfigPListTool.h"

@implementation UIView (MyView)

-(void)toast:(NSString *)text yOffset:(float)yoffset
{
    __block MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:HUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    NSString *tempStr =[[ConfigPListTool sharedManager] getConfig:@"sc_y"];
    CGFloat f = 1;
    if (tempStr != nil) {
        f = [tempStr floatValue];
    }
    
    HUD.yOffset = 150.0f * f;//默认偏移
    if (yoffset != 0) {
        HUD.yOffset = yoffset * f;
    }
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [HUD removeFromSuperview];
        HUD = nil;
    }];
}





@end
