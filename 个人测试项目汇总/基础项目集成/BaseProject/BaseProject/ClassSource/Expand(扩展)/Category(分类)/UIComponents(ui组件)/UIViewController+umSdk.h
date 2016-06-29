//
//  UIViewController+umSdk.h
//  NewGWPhone
//
//  Created by 钟天任 on 16/1/22.
//  Copyright © 2016年 梁宇辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (umSdk)

/*****************************************************************************
 功能描述  : 将类c1中方法orig的实现替换为类c2中方法newSel的实现
 输入参数  : (Class)c1
 (SEL)orig
 (Class)c2
 (SEL)newSel
 返 回 值  : BOOL
 *****************************************************************************/
+ (BOOL)swizzle:(Class)c1 oSelector:(SEL)orig Class:(Class)c2 aSelector:(SEL)newSel;


@end
