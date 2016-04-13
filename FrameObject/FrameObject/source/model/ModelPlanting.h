//
//  ModelPlanting.h
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWBaseModel.h"
//属性列表
@interface ModelPlanting : XWBaseModel

@property(strong,nonatomic)NSString *name;//名称
@property(assign,nonatomic)int mId;//id
@property(assign,nonatomic)int type1_id;//所属分类1
@property(assign,nonatomic)int type2_id;//所属分类2
@property(assign,nonatomic)int times_hour;//时间1
@property(assign,nonatomic)int times_min;//时间2

@property(assign,nonatomic)int tili;//体力
@property(assign,nonatomic)int huoli;//活力
@property(assign,nonatomic)int number;//兑换数量
@property(strong,nonatomic)NSString *danwei;//兑换单位

@end
