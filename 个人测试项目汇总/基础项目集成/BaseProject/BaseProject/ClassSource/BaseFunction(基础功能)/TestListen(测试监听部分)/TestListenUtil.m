//
//  TestListenUtil.m
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/28.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "TestListenUtil.h"

@implementation TestListenUtil


+(void)pushNectRequestResult:(NSString *)reqUrl error:(NSError *)error responseObject:(id)responseObject{
    
    if (!DEBUG) {
        return;
    }
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isListen_nect"] isEqualToString:@"1"]) {
//        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //子线程内部(耗时代码写在这里)
        //H回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程内容
            NSString *testUrl = @"http://192.168.2.5:8082/MyJFinalApp/Listen/pushResult";
            
            AFHTTPSessionManager *session = [[MyAFHTTPSessionManager sharedManager] getSessionManager];
            
            //    AFHTTPRequestSerializer            二进制格式
            //    AFJSONRequestSerializer            JSON
            //    AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
            session.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传普通格式
            [session.requestSerializer setValue: @"application/json" forHTTPHeaderField:@"Content-type"];//设置请求的头
            //Responses 响应Header参数
            session.responseSerializer = [AFJSONResponseSerializer serializer];
            //系统参数
            session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"requestUrl"] = @"133";
            params[@"params"] = @"params";
            if (error) {
                params[@"result"] = @"请求失败";
                params[@"resultInfo"] = error.userInfo[@"NSLocalizedDescription"];
            }else{
                params[@"result"] = @"请求成功";
                params[@"resultInfo"] = responseObject;
            }
            
            [session POST:testUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DLog(@"监控发送成功");
                [[MyAFHTTPSessionManager sharedManager] returnToSessionManager:session];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error1) {
                DLog(@"监控发送失败");
                DLog(@"error:%@",error1.userInfo)
                [[MyAFHTTPSessionManager sharedManager] returnToSessionManager:session];
            }];

        });
    });
    
}


@end
