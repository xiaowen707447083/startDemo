//
//  MyAFHTTPSessionManager.m
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/28.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "MyAFHTTPSessionManager.h"

@interface MyAFHTTPSessionManager()

@property(strong,nonatomic)NSMutableArray *sessionArr;
@property(strong,nonatomic)NSObject *obj;

@end

@implementation MyAFHTTPSessionManager

+ (MyAFHTTPSessionManager *)sharedManager
{
    static MyAFHTTPSessionManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        sharedAccountManagerInstance.obj = [[NSObject alloc] init];
        sharedAccountManagerInstance.sessionArr =[NSMutableArray array];
    });
    return sharedAccountManagerInstance;
}


//获取链接
-(AFHTTPSessionManager *)getSessionManager{
    
    @synchronized (_obj) {
        AFHTTPSessionManager *manager = nil;
        if (_sessionArr.count == 0) {
            manager = [AFHTTPSessionManager manager];
            [_sessionArr addObject:manager];
        }
        manager = [_sessionArr lastObject];
        [_sessionArr removeLastObject];
        return manager;
    }

}

//返回session链接
-(void)returnToSessionManager:(AFHTTPSessionManager *)sessionManager{
    
    @synchronized (_obj) {
        if (_sessionArr.count > 5) {
            return;
        }
        [_sessionArr addObject:sessionManager];
    }
}





@end
