//
//  main.m
//  正则表达式
//
//  Created by G-emall on 16/5/19.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Extension.h"

# define DLog(fmt, ...) NSLog((@"[目录：%s][函数名:%s]" "[行号:%d] \n" fmt),__FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSLog(@"ipv4:%@",[NSString getIPAddressIpv4]);
         NSLog(@"ipv6:%@",[NSString getIPAddressIpv6]);
        
//        DLog1([NSString getIPAddressIpv4]);
//        DLog1([NSString getIPAddressIpv6]);
       
//        DLog1(@"这只是一个测试");
//        DLog1(@"这只是一个测试%@",@"1");
        
//        NSString *ss = @"333<img src=image/ad1.gif width=\"127\" height=\"36\" />iii<img src='image/ad2.gif' width=\"128\" height=\"36\" />555";
//        NSRange range = [ss rangeOfString:@"<img" options:NSRegularExpressionSearch];
//        
//        NSLog(@"location:%ld,length:%ld",range.location,range.length);
//        
//        
//        NSString *searchText = ss;
//        NSError *error = NULL;
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<img.*/>" options:NSRegularExpressionCaseInsensitive error:&error];
//        NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
//        if (result) {
//            NSLog(@"%@", [searchText substringWithRange:result.range]);
//        }
//        
//        
//        
//        NSString *pattern = @"<img[^>]*/>";
//        NSArray *resultArr =   [ss machesWithPattern:pattern];
//        
//        for (NSTextCheckingResult *result in resultArr) {
//   
//            NSLog(@"result.range.location:%ld,result.range.length:%ld",result.range.location,result.range.length);
//            
//            
//        }
        
        
    }
    return 0;
}






