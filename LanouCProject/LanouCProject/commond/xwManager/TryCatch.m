//
//  TryCatch.m
//  LanouBProject
//
//  Created by lanou on 15/8/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TryCatch.h"

@implementation TryCatch

+(void)try: (void (^)())try catch:(void (^)(NSException *exception))catch finally:(void (^)())finally{
    @try {
        try ? try() : nil;
    }
    @catch (NSException *exception) {
        catch ? catch(exception) : nil;
    }
    @finally {
        finally ? finally() : nil;
    }
}

@end
