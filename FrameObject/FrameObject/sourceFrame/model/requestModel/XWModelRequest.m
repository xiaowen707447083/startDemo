//
//  XWModelRequest.m
//  FrameObject
//
//  Created by shenba on 16/4/8.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWModelRequest.h"
#import "XWDateUtil.h"

@implementation XWModelRequest


- (instancetype)init
{
    self = [super init];
    if (self) {
        //数据初始化
        _headDic = nil;
        _body = @"";
        _readStrategy = nil;
        _writeStrategy = nil;
        _reqType = POST;
        _userApi = @"";

        _systemUUID = [self getTimstempCurrent];
        _otherDeal = nil;
        
    }
    return self;
}



/**普通请求对象生成*/
+(id)modelWithName:(NSString *)userApi{
    XWModelRequest *xwrequest = [[XWModelRequest alloc] init];
    xwrequest.userApi = userApi;
    
    return xwrequest;
}

/**打印对象*/
-(void)describe{

    NSLog(@"*******************");
    NSLog(@"请求头:%@",_headDic);
    NSLog(@"请求体:%@",_body);
    if (_readStrategy!=nil) {
        NSLog(@"--读缓存策略--");
        describe(_readStrategy)
        NSLog(@"-------------");
    }
    
    if (_writeStrategy!=nil) {
        NSLog(@"--写缓存策略--");
        describe(_writeStrategy)
        NSLog(@"-------------");
        
    }
    
    
     NSLog(@"请求方式:%d",_reqType);
    NSLog(@"用户api:%@",_userApi);
     NSLog(@"唯一标识时间戳:%@",_systemUUID);
    

    NSDate *date = [self dateWithTimestempStr:_systemUUID];
    
    
    NSString *dataStr = [XWDateUtil strWithDate:date withForMet:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"请求时间:%@",dataStr);
    
    
    
    if (_otherDeal!=nil) {
        NSLog(@"--其他处理--");
        describe(_otherDeal)
        NSLog(@"-------------");
    }
    NSLog(@"*******************");
}



//判断是否为整型
- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}

//获取当前时间戳字符串
-(NSString *)getTimstempCurrent{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%f", a];//
}



//时间戳字符转时间类型
-(NSDate *)dateWithTimestempStr:(NSString *)timestempStr{
    if ([self isPureFloat:timestempStr]) {
        return [NSDate  dateWithTimeIntervalSince1970:[timestempStr floatValue]/1000];
    }
    return nil;
}



//字符串转时间
-(NSDate *)dateWithStr:(NSString *)dateStr withForMet:(NSString *)forMet{
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:forMet];
    
    [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"] ];
    
    
    return [df dateFromString:dateStr];
}


@end
