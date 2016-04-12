//
//  Planting_LiftSkills.h
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ModelAttribute.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ModelAttribute_LiftSkills : NSObject

//列表
@property(strong,nonatomic)NSMutableArray *dataList;

//获取cell;
-(void)updateCell:(ModelAttribute *)model cell:(UITableViewCell *)cell;
//获取高度
-(CGFloat)getCellHeight;

//调转到详情页面
-(void)turnToDetailWithModel:(ModelAttribute *)model viewController:(UIViewController *)viewController;

@end
