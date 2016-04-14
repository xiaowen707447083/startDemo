//
//  HomeSearchModel_HomeSearchView.m
//  AFNetworking+Pod
//
//  Created by shenba on 16/4/14.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "AFNetworking.h"
#import "HomeSearchModel_HomeSearchView.h"

@implementation HomeSearchModel_HomeSearchView

-(NSArray *)getKeyWorkFromData{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    //afnetworking请求网络数据
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"20131129", @"date", @"1", @"startRecord", @"5", @"len", @"1234567890", @"udid", @"Iphone", @"terminalType", @"213", @"cid", nil];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // Get请求
    [manager GET:@"http://pc.api.shenba.com/index.php?act=index&op=index&client=android&page_size=15&version=v1.12" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        NSLog(@"%@", responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"%@", dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
    }];
    
    
    
    
    return arr;
}


@end
