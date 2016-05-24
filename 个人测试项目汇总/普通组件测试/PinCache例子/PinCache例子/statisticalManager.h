//
//  statisticalManager.h
//  PinCache例子
//
//  Created by G-emall on 16/5/23.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface statisticalManager : NSObject

@property(nonatomic,assign)id manager;

+ (statisticalManager *)sharedManager;

-(void)clickBtn:(NSString *)name params:(NSDictionary *)dic;

@end
