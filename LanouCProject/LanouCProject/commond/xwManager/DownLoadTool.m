//
//  DownLoadTool.m
//  UI18_UICollectionView
//
//  Created by lanou on 15/7/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DownLoadTool.h"

@implementation DownLoadTool

-(void)downLoadData:(NSString *)strUrl
{
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    //异步block请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"网络请求出错");
            return;
        }
        //下载结束,用代理传值的方式将下载的数据传回,//
        [self.myDelegate sendDataFromTool:data];
        
    }];
}

@end
