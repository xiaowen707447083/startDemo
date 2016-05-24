//
//  statisticalManager.m
//  PinCache例子
//
//  Created by G-emall on 16/5/23.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "statisticalManager.h"

@implementation statisticalManager

//单例实现对象方法
+ (statisticalManager *)sharedManager
{
    static statisticalManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}


//放入管理回调类
-(void)setManager:(id)manager{
    
    _manager = manager;
}

-(void)clickBtn:(NSString *)name params:(NSDictionary *)dic{
    
    if (_manager) {
        if ([_manager respondsToSelector:@selector(clickBtn:params:)]) {
            [_manager performSelector:@selector(clickBtn:params:) withObject:name withObject:dic ];
            [_manager performSelector:@selector(clickBtn:params:) withObject:name withObject:dic ];
        }
    }
    
    
}



@end
