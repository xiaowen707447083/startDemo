//
//  XWLocationUtil.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWLocationUtil.h"
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>

@implementation XWLocationUtil


- (void)startUpdateAccelerometer
{
    
     CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    /* 设置采样的频率，单位是秒 */
    NSTimeInterval updateInterval = 0.05; // 每秒采样20次
    //    CGSize size = [self superview].frame.size;
    //    __block CGRect f = [self frame];
    __block int stepCount = 0; // 步数
    //在block中，只能使用weakSelf。
    
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    /* 判断是否加速度传感器可用，如果可用则继续 */
    if ([motionManager isAccelerometerAvailable] == YES) {
        /* 给采样频率赋值，单位是秒 */
        [motionManager setAccelerometerUpdateInterval:updateInterval];
        /* 加速度传感器开始采样，每次采样结果在block中处理 */
        [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             CGFloat sqrtValue =sqrt(accelerometerData.acceleration.x*accelerometerData.acceleration.x+accelerometerData.acceleration.y*accelerometerData.acceleration.y+accelerometerData.acceleration.z*accelerometerData.acceleration.z);
             // 走路产生的震动率
             NSLog(@"X = %.04f, Y = %.04f, Z = %.04f",accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
             
//             if (sqrtValue > 1.552188 && valiadCountStep)
             if (sqrtValue > 1.552188)
             {
                
//                 displayLink.paused = NO;
//                 [Database save:TableLocalFoot entity:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"footid",[[NSUserDefaults standardUserDefaults] valueForKey:@"token"],@"userid",[NSDate date],@"time", nil]];
//                 //                 [self.delegate totleNum:stepCount];
                 stepCount +=1;
                  NSLog(@"你在走路哦:%d",stepCount);
//                 valiadCountStep = NO;
             }
         }];
    }
}

@end
