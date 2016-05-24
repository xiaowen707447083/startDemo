//
//  NSString+Extension.h
//  测试textview放图片
//
//  Created by G-emall on 16/5/19.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSArray <NSTextCheckingResult *> *)machesWithPattern:(NSString *)pattern;

@end
