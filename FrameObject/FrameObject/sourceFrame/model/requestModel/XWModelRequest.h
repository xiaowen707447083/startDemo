//
//  XWModelRequest.h
//  FrameObject
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

//调用描述的方法
#define describe(a) if ([a respondsToSelector:@selector(describe)]) {[a performSelector:@selector(describe)];}

#import "XWBaseModel.h"
#import "XWModelOtherRequestDeal.h"
#import "XWModelCacheStrategyRead.h"
#import "XWModelCacheStrategyWrite.h"

//枚举请求方式
enum xWEnumRequestType{
    GET = 0,
    POST
} typedef XWEnumRequestType;

@interface XWModelRequest : XWBaseModel

//请求头
@property(strong,nonatomic)NSMutableDictionary *headDic;
//请求体
@property(strong,nonatomic)NSString *body;
//读缓存策略
@property(strong,nonatomic)XWModelCacheStrategyRead *readStrategy;
//写缓存策略
@property(strong,nonatomic)XWModelCacheStrategyWrite *writeStrategy;
//请求方式
@property(assign,nonatomic)XWEnumRequestType reqType;
//请求唯一标识
@property(strong,nonatomic)NSString *userApi;
//请求唯一标识(自动)
@property(strong,nonatomic)NSString *systemUUID;
//其他请求处理策略对象
@property(strong,nonatomic)XWModelOtherRequestDeal *otherDeal;


/**普通请求对象生成*/
+(id)modelWithName:(NSString *)userApi;
/**打印对象*/
-(void)describe;


@end
