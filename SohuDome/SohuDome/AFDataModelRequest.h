//
//  AFDataModelRequest.h
//  SohuDome
//
//  Created by lanou3g on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieBaseInfo.h"
#import "SohuBaseNetworkRequestPrmopt.h"
#import "MovieClassifyInfo.h"


@interface AFDataModelRequest : NSObject

-(void)requestMovieBaseInfoWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure;

-(void)requestCarouselFigureViewImage:(NSDictionary *)dic success:(void(^)(NSArray *imageArray))successWithData failed:(void(^)(DataErrorType type))failure;

-(void)requestMovieClassifyInfoWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure;

-(void)requestMovieBaseInfoListWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure;

-(void)requestMovieClassifyInfoDownWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure;

-(void)requestMovieSearchWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure;

-(void)requestMovieDetailWithPara:(NSDictionary *)dic success:(void(^)(NSArray *model))successWithData failed:(void(^)(DataErrorType type))failure;


@end
