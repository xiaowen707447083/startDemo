//
//  SohuBaseNetworkRequestPrmopt.m
//  SohuDome
//
//  Created by lanou3g on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "SohuBaseNetworkRequestPrmopt.h"

@implementation SohuBaseNetworkRequestPrmopt
- (void)dealWithErrorWithController:(UIViewController *)viewController withErrorNO:(DataErrorType)erronNO
{
    switch (erronNO) {
        case DE_DATA_CHECK_ERROR:
            [viewController showHint:@"数据异常，请稍候再试"];
            break;
        case NET_ERROR:
            [viewController showHint:@"网络异常，请检查网络"];
            break;
        default:
            break;
    }

    
}
@end
