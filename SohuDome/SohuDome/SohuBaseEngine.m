//
//  SohuBaseEngine.m
//  SohuDome
//
//  Created by lanou3g on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "SohuBaseEngine.h"
#import "AFNetworking.h"

@implementation SohuBaseEngine

+ (void)getFromURL:(NSString *)URLString params:(NSDictionary *)params withSuccess:(sohuRequestSuccessBack)success withFailure:(sohuRequestFailedBack)failure
{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:URLString]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",nil];
   
    [manager GET:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            success(responseObject);
        }else{
            success(nil);
        }
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          failure(error);
    }];
    
    
    
}


+ (void)postFromURL:(NSString *)URLString params:(NSDictionary *)params withSuccess:(sohuRequestSuccessBack)success withFailure:(sohuRequestFailedBack)failure

{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:URLString]];
    
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    [manager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        if (responseObject) {
            success(responseObject);
        }else{
            success(nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);

    }];
    

    
}

@end
