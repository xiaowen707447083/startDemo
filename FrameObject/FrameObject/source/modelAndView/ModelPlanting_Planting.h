//
//  ModelPlanting_Planting.h
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ModelPlanting.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ModelPlanting_Planting : NSObject

//类型1
@property(strong,nonatomic)NSString *type1;
//类型2
@property(strong,nonatomic)NSString *type2;
//列表
@property(strong,nonatomic)NSMutableArray *dataList;

//获取cell;
-(void)updateCell:(ModelPlanting *)model cell:(UITableViewCell *)cell;
//获取高度
-(CGFloat)getCellHeight;

//调转到详情页面
-(void)turnToDetailWithModel:(ModelPlanting *)model viewController:(UIViewController *)viewController;

@end
