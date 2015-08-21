//
//  TryCatch.h
//  LanouBProject
//
//  Created by lanou on 15/8/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TryCatch : NSObject

/**
 *  捕获异常操作,
 *  该操作只能捕获到同线程下的数据,比如你在一条异步线程外边catch不能捕获到异常(只能进去异步线程里面区捕获)
 *
 *  @param try     <#try description#>
 *  @param catch   <#catch description#>
 *  @param finally <#finally description#>
 */
+(void)try: (void (^)())try catch:(void (^)(NSException *exception))catch finally:(void (^)())finally;

@end
