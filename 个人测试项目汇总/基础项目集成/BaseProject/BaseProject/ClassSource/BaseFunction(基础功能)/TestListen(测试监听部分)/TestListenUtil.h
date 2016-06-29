//
//  TestListenUtil.h
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/28.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestListenUtil : NSObject


+(void)pushNectRequestResult:(NSString *)reqUrl error:(NSError *)error responseObject:(id)responseObject;

@end
