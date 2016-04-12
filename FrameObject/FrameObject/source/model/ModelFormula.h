//
//  ModelFormula.h
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//
//配方
#import "XWBaseModel.h"

@interface ModelFormula : XWBaseModel

@property(assign,nonatomic)int mid;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSMutableDictionary *materials;//
@property(assign,nonatomic)int dynamic; //活力
@property(assign,nonatomic)int PhysicalStrength;//体力


@end
