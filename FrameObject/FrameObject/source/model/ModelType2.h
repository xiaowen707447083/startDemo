//
//  ModelType2.h
//  FrameObject
//
//  Created by shenba on 16/4/13.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "XWBaseModel.h"
//种植,烹饪
@interface ModelType2 : XWBaseModel

@property(strong,nonatomic)NSString *name;//属性名
@property(assign,nonatomic)int mid;//属性id
@property(assign,nonatomic)int type1_id;//所属分类

@end
