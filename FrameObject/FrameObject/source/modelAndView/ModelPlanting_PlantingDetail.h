//
//  ModelPlanting_PlantingDetail.h
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ModelPlanting.h"
#import "ModelFormula.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ModelPlanting_PlantingDetail : NSObject



@property(strong,nonatomic)ModelPlanting *model;

@property(strong,nonatomic)NSString *tf_time_text;//显示的时间
@property(strong,nonatomic)NSString *tf_time_nest;//显示的时间2

@property(strong,nonatomic)NSString *tf_huoli_text;//活力
@property(strong,nonatomic)NSString *tf_tili_text;//体力
@property(strong,nonatomic)NSString *tf_duihuan_text;//兑换


//获取所以的配方
-(NSMutableArray *)getPeifangAll;

-(void)updateBottomView:(ModelFormula *)fo view:(UIScrollView *)scrollerView;


@end
