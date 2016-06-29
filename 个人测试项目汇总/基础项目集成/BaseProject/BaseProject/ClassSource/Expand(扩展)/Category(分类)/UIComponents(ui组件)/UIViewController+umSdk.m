//
//  UIViewController+umSdk.m
//  NewGWPhone
//
//  Created by 钟天任 on 16/1/22.
//  Copyright © 2016年 梁宇辉. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "UIViewController+umSdk.h"
#import "GWStatisticalUtil.h"

@implementation UIViewController (umSdk)

+ (void)load {
    static dispatch_once_t onceToken_load;
    dispatch_once(&onceToken_load, ^{
//        Method originalMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
//        Method replacementMethod = class_getInstanceMethod([self class], @selector(umemgSdk_viewDidAppear:));
//        method_exchangeImplementations(replacementMethod, originalMethod);
        
        [self swizzle:[self class] oSelector:@selector(viewDidAppear:) Class:[self class] aSelector:@selector(umemgSdk_viewDidAppear:)];
        
        [self swizzle:[self class] oSelector:@selector(viewDidDisappear:) Class:[self class] aSelector:@selector(umemgSdk_viewDidDisappear:)];
        
    });
}

- (void)umemgSdk_viewDidAppear:(BOOL)animated {
    [self umemgSdk_viewDidAppear:animated];
    if ([self isStatistical:NSStringFromClass([self class])]) {
        DLog(@"%@_开始显示_触发统计",NSStringFromClass([self class]))
        [GWStatisticalUtil onPageViewBegin:self];
    }
}

- (void)umemgSdk_viewDidDisappear:(BOOL)animated {
    [self umemgSdk_viewDidDisappear:animated];
    if ([self isStatistical:NSStringFromClass([self class])]) {
        DLog(@"%@_结束显示_触发统计",NSStringFromClass([self class]))
        [GWStatisticalUtil onPageViewEnd:self];
    }
}


//不触发统计的view
-(Boolean)isStatistical:(NSString *)viewName{
    if ([viewName isEqualToString:@"UICompatibilityInputViewController"]) {
        return NO;
    }else if([viewName isEqualToString:@"UIInputWindowController"]) {
        return NO;
    }else if([viewName isEqualToString:@"UIKeyboardCandidateGridCollectionViewController"]) {
        return NO;
    }else if([viewName isEqualToString:@"UIAlertController"]) {
        return NO;
    }else if([viewName isEqualToString:@"UIApplicationRotationFollowingController"]) {
        return NO;
    }
    
    
    return YES;
}


/*****************************************************************************
 功能描述  : 将类c1中方法orig的实现替换为类c2中方法newSel的实现
 输入参数  : (Class)c1
 (SEL)orig
 (Class)c2
 (SEL)newSel
 返 回 值  : BOOL
 *****************************************************************************/
+ (BOOL)swizzle:(Class)c1 oSelector:(SEL)orig Class:(Class)c2 aSelector:(SEL)newSel{
    /*注意区分实例方法和类方法：实例方法用getInstanceMethod,类方法：getClassMethod*/
    Method origMethod = class_getInstanceMethod(c1, orig);
    Method newMethod = class_getInstanceMethod(c2, newSel);
    
    if (NULL == origMethod)
    {
        NSLog(@"can't find orig method %@ in class %@",NSStringFromSelector(orig),c1);
        return NO;
    }
    if (NULL == newMethod)
    {
        NSLog(@"can't find new method %@ in class %@",NSStringFromSelector(newSel),c2);
        return NO;
    }
    
    /*class_addMethod:add a new method to a class with a given name and implementation(详见官方文档)*/
    BOOL added = class_addMethod(c1, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    
    if(added)
    {
        /*if added success just replace ：NO TEST---MAY HAVE SOME PROBLEM*/
        class_replaceMethod(c1, newSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else
    {
        /*change two method's implementation*/
        method_exchangeImplementations(origMethod, newMethod);
    }
    return YES;
}

@end
