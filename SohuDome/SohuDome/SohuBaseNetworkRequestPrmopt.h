//
//  SohuBaseNetworkRequestPrmopt.h
//  SohuDome
//
//  Created by lanou3g on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+HUD.h"

typedef enum tagDataSourceType
{
    DataSourceCache,
    DataSourceNetwork,
}dataSourceType;

typedef enum
{
    DE_DATA_CHECK_ERROR,
    NET_ERROR ,

}DataErrorType;

@interface SohuBaseNetworkRequestPrmopt : NSObject

- (void)dealWithErrorWithController:(UIViewController *)viewController withErrorNO:(DataErrorType)erronNO;

@end
